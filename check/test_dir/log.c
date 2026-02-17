#include "types.h"
#include "defs.h"
#include "param.h"
#include "fs.h"
#include "buf.h"
#include "logflag.h"

// Simple logging that allows concurrent FS system calls.
//
// A log transaction contains the updates of multiple FS system
// calls. The logging system only commits when there are
// no FS system calls active. Thus there is never
// any reasoning required about whether a commit might
// write an uncommitted system call's updates to disk.
//
// A system call should call begin_op()/end_op() to mark
// its start and end. Usually begin_op() just increments
// the count of in-progress FS system calls and returns.
// But if it thinks the log is close to running out, it
// sleeps until the last outstanding end_op() commits.
//
// The log is a physical re-do log containing disk blocks.
// The on-disk log format:
//   header block, containing block #s for block A, B, C, ...
//   block A
//   block B
//   block C
//   ...
// Log appends are synchronous.

// Contents of the header block, used for both the on-disk header block
// and to keep track in memory of logged block# before commit.
struct logheader {
  int n;
  int block[LOGSIZE];
};

struct log {
  int start;
  int size;
  int committing;  // in commit(), please wait.
  int dev;
  struct logheader lh;
};
struct log log;
// `recovering` selects undo behavior in install_trans() during boot recovery.
static int recovering;

// Persistent stats are stored in block 0 of fs.img.
#define LOGSTATS_BLOCKNO 0

struct logstats {
  uint log_writes;
  uint home_writes;
  uint recovery_undos;
};

struct logstats_disk {
  uint log_writes;
  uint home_writes;
  uint recovery_undos;
};

static struct logstats stats;

static void recover_from_log(void);
static void commit();
static void load_stats(void);
static void persist_stats(void);
static void bump_log_writes(void);
static void bump_home_writes(void);
static void bump_recovery_undos(void);
static void print_stats(void);

void
initlog(int dev)
{
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  load_stats();
  recover_from_log();
  print_stats();
}

// Persist in-memory counters into block 0 of fs.img.
static void
persist_stats(void)
{
  struct buf *buf = bread(log.dev, LOGSTATS_BLOCKNO);
  struct logstats_disk *sd = (struct logstats_disk *)buf->data;

  sd->log_writes = stats.log_writes;
  sd->home_writes = stats.home_writes;
  sd->recovery_undos = stats.recovery_undos;
  bwrite(buf);
  brelse(buf);
}

// Load counters from block 0 of fs.img.
static void
load_stats(void)
{
  struct buf *buf = bread(log.dev, LOGSTATS_BLOCKNO);
  struct logstats_disk *sd = (struct logstats_disk *)buf->data;

  stats.log_writes = sd->log_writes;
  stats.home_writes = sd->home_writes;
  stats.recovery_undos = sd->recovery_undos;
  brelse(buf);
}

// Keep these helpers tiny and explicit so each update is durable.
static void
bump_log_writes(void)
{
  stats.log_writes++;
  persist_stats();
}

static void
bump_home_writes(void)
{
  stats.home_writes++;
  persist_stats();
}

static void
bump_recovery_undos(void)
{
  stats.recovery_undos++;
  persist_stats();
}

// Print once on boot so tests/manual runs can observe persisted counters.
static void
print_stats(void)
{
  cprintf("[STATS] log_writes=%d home_writes=%d recovery_undos=%d\n",
          stats.log_writes, stats.home_writes, stats.recovery_undos);
}

// During recovery: restore old blocks from log to home locations (undo).
// During commit: flush the in-cache modified home blocks to disk (install new).
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    if (PANIC_5) {
      if (tail == log.lh.n/2) panic("[UNDOLOG] Panic in install_trans type 5");
    }
    if (recovering) {
      // Recovery path: undo uncommitted writes with old values from the log.
      struct buf *lbuf = bread(log.dev, log.start+tail+1);
      struct buf *dbuf = bread(log.dev, log.lh.block[tail]);
      memmove(dbuf->data, lbuf->data, BSIZE);
      bwrite(dbuf);
      bump_recovery_undos();
      brelse(lbuf);
      brelse(dbuf);
    } else {
      // Commit path: write the already-modified home buffer to its disk block.
      struct buf *dbuf = bread(log.dev, log.lh.block[tail]);
      bwrite(dbuf);
      bump_home_writes();
      brelse(dbuf);
    }
  }
}

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
}

// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
  brelse(buf);
}

static void
recover_from_log(void)
{
  read_head();
  // A non-empty header at boot means crash before commit completed.
  recovering = 1;
  install_trans();
  recovering = 0;
  log.lh.n = 0;
  write_head(); // clear the log
}

// called at the start of each FS system call.
void
begin_op(void)
{
  // This lab setup commits at each end_op(), so begin_op() is a no-op.
}

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
  // call commit w/o holding locks, since not allowed
  // to sleep with locks.
  recovering = 0; // commit path installs new data, not undo data
  commit();
}

/* DO NOT MODIFY THIS FUNCTION*/
static void
commit()
{
  if (log.lh.n > 0) {
    if (PANIC_1) {
      panic("[UNDOLOG] Panic in commit type 1");
    }
    write_head();    // Write header to disk 
    if (PANIC_2) {
      panic("[UNDOLOG] Panic in commit type 2");
    }
    install_trans(); // Now install writes to home locations    
    if (PANIC_3) {
      panic("[UNDOLOG] Panic in commit type 3");
    }
    log.lh.n = 0;
    write_head();    // Erase the transaction from the log 
    if (PANIC_4) {
      panic("[UNDOLOG] Panic in commit type 4");
    }  
  }
}

// Check if a home block is already part of the active in-memory transaction.
int
log_has_block(uint blockno)
{
  int i;

  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == blockno)
      return 1;
  }
  return 0;
}

// Caller has modified b->data and is done with the buffer.
// Record the block number and pin in the cache with B_DIRTY.
// commit()/write_log() will do the disk write.
//
// log_write() replaces bwrite(); a typical use is:
//   bp = bread(...)
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");

  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }

  if (i == log.lh.n) {
    struct buf *lbuf;

    // First write to this block in the transaction: assign log slot.
    log.lh.block[i] = b->blockno;

    // Old block image comes from bread/bread_wr snapshot without extra read.
    if (!b->undo_cached)
      panic("log_write: missing undo cache");

    // Eagerly persist old data into the log block.
    lbuf = bread(log.dev, log.start + i + 1);
    memmove(lbuf->data, b->undo_data, BSIZE);
    bwrite(lbuf);
    bump_log_writes();
    brelse(lbuf);

    // Publish the enlarged transaction eagerly in the on-disk header.
    log.lh.n++;
    write_head();
  }
  b->flags |= B_DIRTY; // prevent eviction
}
