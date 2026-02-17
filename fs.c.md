# `fs.c` Function Notes

## Exposed Functions

### `readsb(int dev, struct superblock *sb)`
1. Arguments (intended purpose): `dev` device id; `sb` output superblock structure.
2. Body (brief): Reads disk block 1 and copies superblock bytes into caller-provided struct.
3. Return: `void`.
4. Sample use case: Called by `log.c:initlog` at `log.c:59` and by `iinit` at `fs.c:119`.

### `iinit(int dev)`
1. Arguments (intended purpose): `dev` filesystem device id.
2. Body (brief): Loads superblock into global `sb` and prints geometry metadata.
3. Return: `void`.
4. Sample use case: Boot path calls it at `main.c:56`.

### `struct inode* ialloc(uint dev, short type)`
1. Arguments (intended purpose): `dev` device id; `type` inode type to allocate.
2. Body (brief): Scans on-disk inode table for free inode, initializes it, logs inode-block update, returns cached inode pointer.
3. Return: Allocated inode pointer; panics if out of inodes.
4. Sample use case: Used by file creation helper at `file.c:214`.

### `void iput(struct inode *ip)`
1. Arguments (intended purpose): `ip` inode whose in-memory reference should be dropped.
2. Body (brief): If last reference and link count is zero, truncates data, marks inode free on disk, then decrements refcount.
3. Return: `void`.
4. Sample use case: Used heavily in file lifecycle paths, e.g. `file.c:59`, `file.c:180`, `file.c:184`.

### `void iupdate(struct inode *ip)`
1. Arguments (intended purpose): `ip` in-memory inode whose persistent fields changed.
2. Body (brief): Copies inode metadata/addresses into on-disk dinode slot and logs that block write.
3. Return: `void`.
4. Sample use case: Called after link/size/type changes, e.g. `file.c:178`, `file.c:183`, `fs.c:382`.

### `struct inode* iget(uint dev, uint inum)`
1. Arguments (intended purpose): `dev` device id; `inum` inode number to fetch/cache.
2. Body (brief): Looks up cached inode entry or allocates an empty cache slot and initializes it.
3. Return: In-memory inode pointer with incremented reference.
4. Sample use case: Used by path traversal and directory lookup, e.g. `fs.c:416`, `fs.c:502`.

### `void iread(struct inode *ip)`
1. Arguments (intended purpose): `ip` inode that may need lazy on-disk load.
2. Body (brief): Validates refcount, reads dinode if not already valid, fills in-memory inode fields.
3. Return: `void`.
4. Sample use case: Called before inode operations in `file.c:69`, `file.c:85`, `file.c:156`.

### `void stati(struct inode *ip, struct stat *st)`
1. Arguments (intended purpose): `ip` source inode; `st` output stat struct.
2. Body (brief): Copies inode metadata fields (`dev`, `inum`, `type`, `nlink`, `size`) into `st`.
3. Return: `void`.
4. Sample use case: `filestat` uses it at `file.c:70`.

### `int readi(struct inode *ip, char *dst, uint off, uint n)`
1. Arguments (intended purpose): `ip` file inode, `dst` destination buffer, `off` byte offset, `n` requested bytes.
2. Body (brief): Validates bounds, maps file blocks with `bmap`, copies bytes from block data to caller buffer.
3. Return: Bytes read on success, `-1` on invalid request.
4. Sample use case: Used by `fileread` (`file.c:86`) and directory scans (`fs.c:407`, `file.c:135`).

### `int writei(struct inode *ip, char *src, uint off, uint n)`
1. Arguments (intended purpose): `ip` inode to modify, `src` source buffer, `off` byte offset, `n` bytes to write.
2. Body (brief): Validates bounds, allocates/maps blocks via `bmap`, writes bytes into buffers, logs each modified block, updates inode size if extended.
3. Return: Bytes written on success, `-1` on invalid request.
4. Sample use case: Used by `filewrite` at `file.c:112`, directory update in `file.c:174` and `fs.c:448`.

### `int namecmp(const char *s, const char *t)`
1. Arguments (intended purpose): Two directory-entry names to compare.
2. Body (brief): Performs fixed-width name comparison using `strncmp(..., DIRSIZ)`.
3. Return: `0` when equal, non-zero otherwise.
4. Sample use case: Used in `dirlookup` (`fs.c:411`) and unlink guard (`file.c:159`).

### `struct inode* dirlookup(struct inode *dp, char *name, uint *poff)`
1. Arguments (intended purpose): `dp` directory inode, `name` target entry, optional `poff` output for byte offset.
2. Body (brief): Iterates directory entries, matches by `namecmp`, optionally stores offset, returns inode for matching entry.
3. Return: Matching inode pointer or `0` if absent.
4. Sample use case: Used in `file.c:162` (unlink), `file.c:205` (create), and `fs.c:namex` (`fs.c:514`).

### `int dirlink(struct inode *dp, char *name, uint inum)`
1. Arguments (intended purpose): `dp` parent directory inode, `name` new entry name, `inum` inode number to link.
2. Body (brief): Rejects duplicate names, finds empty directory slot, writes new `dirent` via `writei`.
3. Return: `0` on success, `-1` if name already exists.
4. Sample use case: Used during create path in `file.c:227` and `file.c:231`.

### `struct inode* namei(char *path)`
1. Arguments (intended purpose): `path` absolute/relative pathname to resolve.
2. Body (brief): Calls `namex(path, 0, name)` to resolve full path to target inode.
3. Return: Target inode pointer or `0` if resolution fails.
4. Sample use case: Used by `open` at `file.c:254`.

### `struct inode* nameiparent(char *path, char *name)`
1. Arguments (intended purpose): `path` pathname to resolve, `name` output last path component.
2. Body (brief): Calls `namex(path, 1, name)` to stop at parent directory.
3. Return: Parent inode pointer or `0` if resolution fails.
4. Sample use case: Used in `unlink` (`file.c:151`) and `create` (`file.c:201`).

## Local Helper Functions (`static`)

### `bzero(int dev, int bno)`
1. Arguments (intended purpose): `dev` device id and `bno` block number to clear.
2. Body (brief): Reads block for write, fills it with zero bytes, logs the update, releases buffer.
3. Return: `void`.

### `balloc(uint dev)`
1. Arguments (intended purpose): `dev` device id to allocate one free data block from.
2. Body (brief): Scans bitmap blocks for free bit, marks allocation, logs bitmap change, zeroes allocated block.
3. Return: Allocated block number; panics when disk has no free block.

### `bfree(int dev, uint b)`
1. Arguments (intended purpose): `dev` device id; `b` data block number to free.
2. Body (brief): Reads corresponding bitmap block, verifies bit is set, clears it, logs bitmap update.
3. Return: `void`.

### `bmap(struct inode *ip, uint bn)`
1. Arguments (intended purpose): `ip` inode and logical block index `bn` within file.
2. Body (brief): Returns/allocates direct block for small indices, otherwise handles single-indirect block lookup/allocation.
3. Return: Physical disk block number for logical block; panics on out-of-range index.

### `itrunc(struct inode *ip)`
1. Arguments (intended purpose): `ip` inode whose file contents should be fully discarded.
2. Body (brief): Frees all direct and indirect data blocks, clears inode addresses and size, persists inode update.
3. Return: `void`.

### `skipelem(char *path, char *name)`
1. Arguments (intended purpose): `path` current pathname cursor; `name` output buffer for next path element.
2. Body (brief): Skips leading slashes, copies next element into `name` (DIRSIZ-aware), advances pointer to remaining path.
3. Return: Pointer to remaining path string, or `0` if no element.

### `namex(char *path, int nameiparent, char *name)`
1. Arguments (intended purpose): `path` to resolve, `nameiparent` flag for parent-vs-target behavior, `name` output for final element.
2. Body (brief): Starts from root inode, repeatedly parses elements via `skipelem`, traverses directories via `dirlookup`, and optionally stops one level early.
3. Return: Resolved inode pointer, or `0` on failure.
