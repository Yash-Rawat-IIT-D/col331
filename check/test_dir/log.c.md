# `log.c` Function Notes

## Exposed Functions

### `initlog(int dev)`
1. Arguments (intended purpose): `dev` is the disk device number whose superblock/log region should be initialized.
2. Body (brief): Validates log-header size, reads superblock via `readsb`, sets `log.start/size/dev`, and runs recovery.
3. Return: `void`.
4. Sample use case: Called during boot from `main.c:57` (`initlog(ROOTDEV)`).

### `begin_op(void)`
1. Arguments (intended purpose): No arguments; marks start of an FS operation boundary.
2. Body (brief): In this lab code, intentionally a no-op (commit is triggered at `end_op`).
3. Return: `void`.
4. Sample use case: Used before inode-changing work in `file.c:58`, `file.c:110`, `file.c:150`, `file.c:245`, `file.c:286`.

### `end_op(void)`
1. Arguments (intended purpose): No arguments; marks the end of an FS operation and triggers commit work.
2. Body (brief): Sets commit mode (`recovering = 0`) and calls `commit()`.
3. Return: `void`.
4. Sample use case: Paired with `begin_op()` in write path at `file.c:114` and close/unlink/open/mkdir flows.

### `int log_has_block(uint blockno)`
1. Arguments (intended purpose): `blockno` is the home-disk block to check for presence in current in-memory transaction header.
2. Body (brief): Scans `log.lh.block[0..n-1]` and returns whether `blockno` is already part of this transaction.
3. Return: `1` if found, else `0`.
4. Sample use case: Used by undo-image caching guard in `bio.c:40`.

### `log_write(struct buf *b)`
1. Arguments (intended purpose): `b` is a modified home buffer that should be tracked in the current transaction.
2. Body (brief): Checks log space, performs log absorption, and on first touch of a block writes cached old image to its log slot eagerly and updates on-disk header eagerly.
3. Return: `void`.
4. Sample use case: Called by FS metadata/data updates, e.g. `fs.c:47`, `fs.c:67`, `fs.c:92`, `fs.c:142`, `fs.c:376`.

## Local Helper Functions (`static`)

### `install_trans(void)`
1. Arguments (intended purpose): No arguments; installs transaction effects based on mode.
2. Body (brief): If recovering, copies old log images back to home blocks (undo). Otherwise flushes modified home buffers to disk (install new data).
3. Return: `void`.

### `read_head(void)`
1. Arguments (intended purpose): No arguments; load persisted log header into in-memory header.
2. Body (brief): Reads header block at `log.start` and copies `n` and block-number array into `log.lh`.
3. Return: `void`.

### `write_head(void)`
1. Arguments (intended purpose): No arguments; persist in-memory transaction header to disk.
2. Body (brief): Writes `log.lh.n` and `log.lh.block[]` into on-disk header block and flushes it with `bwrite`.
3. Return: `void`.

### `recover_from_log(void)`
1. Arguments (intended purpose): No arguments; run boot-time recovery from any non-empty log header.
2. Body (brief): Reads header, runs undo installation (`recovering=1`), then clears header and writes cleared state.
3. Return: `void`.

### `commit(void)`
1. Arguments (intended purpose): No arguments; complete transaction commit sequence.
2. Body (brief): If `log.lh.n>0`, writes header (commit point), installs transaction to home blocks, clears in-memory header, writes cleared header.
3. Return: `void`.
