# `bio.c` Function Notes

## Exposed Functions

### `binit(void)`
1. Arguments (intended purpose): No arguments; initializes global buffer-cache structures.
2. Body (brief): Builds MRU/LRU doubly linked list for `bcache.buf[]` anchored at `bcache.head`.
3. Return: `void`.
4. Sample use case: Boot initialization calls it at `main.c:53`.

### `struct buf* bread(uint dev, uint blockno)`
1. Arguments (intended purpose): `dev` is device id; `blockno` is disk block to fetch for reading or access.
2. Body (brief): Gets cached buffer (`bget`), reads from disk if not valid, and caches undo snapshot for potential later writes.
3. Return: Pointer to referenced buffer containing the block data.
4. Sample use case: Used throughout FS and log paths, e.g. `fs.c:34`, `fs.c:236`, `log.c:98`.

### `void bwrite(struct buf *b)`
1. Arguments (intended purpose): `b` is a buffer whose current `data` should be written to disk.
2. Body (brief): Marks `B_DIRTY` and invokes IDE sync (`iderw`) to flush.
3. Return: `void`.
4. Sample use case: Used by log code to persist headers/log blocks/home blocks (`log.c:82`, `log.c:88`, `log.c:121`, `log.c:227`).

### `struct buf* bread_wr(uint dev, uint blockno)`
1. Arguments (intended purpose): `dev` and `blockno` for read-with-intent-to-modify paths.
2. Body (brief): Uses `bread` path so caller gets current block and the pre-modify undo snapshot is captured without extra disk reads.
3. Return: Pointer to writable buffer for that disk block.
4. Sample use case: Used in all modifying FS paths, e.g. `fs.c:45`, `fs.c:62`, `fs.c:86`, `fs.c:373`.

### `void brelse(struct buf *b)`
1. Arguments (intended purpose): `b` is a previously referenced buffer to release back to cache.
2. Body (brief): Decrements refcount; when it reaches 0, moves buffer to MRU position in cache list.
3. Return: `void`.
4. Sample use case: Released after block access throughout code, e.g. `fs.c:36`, `log.c:83`, `log.c:228`.

## Local Helper Functions (`static`)

### `cache_undo_image(struct buf *b)`
1. Arguments (intended purpose): `b` is a buffer whose old on-disk image may need to be cached for undo logging.
2. Body (brief): If block is not already in current transaction, copies `b->data` into `b->undo_data` and marks `undo_cached`.
3. Return: `void`.

### `bget(uint dev, uint blockno)`
1. Arguments (intended purpose): `dev` and `blockno` identify requested cached block.
2. Body (brief): Looks up existing cache entry; else recycles an unused non-dirty buffer and initializes metadata for this block.
3. Return: Pointer to referenced buffer slot for requested block.
