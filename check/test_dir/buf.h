struct buf {
  int flags;
  uint dev;
  uint blockno;
  uint refcnt;
  struct buf *prev; // LRU cache list
  struct buf *next;
  struct buf *qnext; // disk queue
  int undo_cached;   // set when undo_data stores the latest pre-modify image
  uchar undo_data[BSIZE]; // cached old on-disk contents used by undo logging
  uchar data[BSIZE];
};
#define B_VALID 0x2  // buffer has been read from disk
#define B_DIRTY 0x4  // buffer needs to be written to disk
