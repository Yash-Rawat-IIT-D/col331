# `file.c` Function Notes

## Exposed Functions

### `struct file* filealloc(void)`
1. Arguments (intended purpose): No arguments; allocate an unused in-memory file descriptor slot.
2. Body (brief): Scans `ftable.file[]` and picks first entry with `ref==0`, then sets `ref=1`.
3. Return: Pointer to allocated `struct file`, or `0` if table is full.
4. Sample use case: Used by `open()` at `file.c:267`.

### `struct file* filedup(struct file *f)`
1. Arguments (intended purpose): `f` is an existing file object whose reference count should be incremented.
2. Body (brief): Validates `ref>=1`, increments refcount.
3. Return: Same pointer `f`.
4. Sample use case: Exposed via `defs.h:24` for descriptor-duplication syscall paths; no direct call inside this lab harness files.

### `void fileclose(struct file *f)`
1. Arguments (intended purpose): `f` is a file object to close (decrement reference and possibly release inode).
2. Body (brief): Decrements refcount; if last ref, clears slot and for inode-backed files wraps `iput` in `begin_op/end_op`.
3. Return: `void`.
4. Sample use case: Called by test flow in `main.c:26` and `main.c:39`.

### `int filestat(struct file *f, struct stat *st)`
1. Arguments (intended purpose): `f` is file object; `st` output struct for metadata.
2. Body (brief): For inode-backed files reads inode and fills stat via `stati`.
3. Return: `0` on success, `-1` for unsupported file type.
4. Sample use case: Exposed through `defs.h:27` for stat syscall path; no direct call in current lab test harness.

### `int fileread(struct file *f, char *addr, int n)`
1. Arguments (intended purpose): `f` file object, `addr` destination buffer, `n` bytes requested.
2. Body (brief): Checks readability/type, calls `readi` at current offset, and advances `f->off` on success.
3. Return: Bytes read (`>=0`) or `-1` on failure.
4. Sample use case: Used by boot test in `main.c:24`.

### `int filewrite(struct file *f, char *addr, int n)`
1. Arguments (intended purpose): `f` file object, `addr` source bytes, `n` bytes to write.
2. Body (brief): Splits large writes into transaction-sized chunks, wraps each chunk in `begin_op/end_op`, calls `writei`, advances offset.
3. Return: `n` on full success, else `-1`.
4. Sample use case: Used by boot test in `main.c:38`.

### `int isdirempty(struct inode *dp)`
1. Arguments (intended purpose): `dp` directory inode to inspect for entries other than `.` and `..`.
2. Body (brief): Iterates directory entries from offset `2*sizeof(dirent)` and checks whether any live inode entry exists.
3. Return: `1` if empty, `0` otherwise.
4. Sample use case: Used in unlink flow at `file.c:168`.

### `int unlink(char* path, char* name)`
1. Arguments (intended purpose): `path` full pathname, `name` last-component buffer used by parent lookup.
2. Body (brief): Finds parent and target, validates rules (`.`/`..`, non-empty dir), clears dirent, updates link counts and persists changes.
3. Return: `0` on success, `-1` on failure.
4. Sample use case: Exposed for unlink syscall via `defs.h:31`; internal helper calls include `nameiparent` (`file.c:151`) and `dirlookup` (`file.c:162`).

### `struct file* open(char* path, int omode)`
1. Arguments (intended purpose): `path` file path, `omode` open flags (`O_CREATE`, `O_RDONLY`, etc.).
2. Body (brief): Starts transaction, creates or resolves inode, validates directory write constraints, allocates `struct file`, fills descriptor fields.
3. Return: Opened `struct file*` on success, else `0`.
4. Sample use case: Used by test flow in `main.c:20` and `main.c:35`.

### `int mkdir(char *path)`
1. Arguments (intended purpose): `path` directory path to create.
2. Body (brief): Starts transaction, calls `create(..., T_DIR, ...)`, releases inode, ends transaction.
3. Return: `0` on success, `-1` on failure.
4. Sample use case: Exposed for directory-creation syscall via `defs.h:29`; no direct call in current lab test harness.

## Local Helper Functions (`static`)

### `create(char *path, short type, short major, short minor)`
1. Arguments (intended purpose): `path` target path, `type` inode type, `major/minor` device ids for special files.
2. Body (brief): Resolves parent, handles existing file case, allocates inode, initializes metadata, creates `.`/`..` for directories, links entry into parent.
3. Return: Newly created or existing inode pointer on success, else `0`.
