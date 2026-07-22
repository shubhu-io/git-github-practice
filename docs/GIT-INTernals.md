---
title: Git Internals
---
# Git Internals

How Git works under the hood.

## The .git Directory

When you initialize a Git repository, Git creates a `.git` directory:

```
.git/
├── HEAD              # Points to current branch/commit
├── config            # Repository-specific configuration
├── description       # Used by GitWeb
├── hooks/            # Client/server-side hook scripts
├── info/             # Excludes file for ignored patterns
├── objects/          # All content (commits, trees, blobs)
│   ├── pack/         # Packed objects
│   └── info/         # Object statistics
├── refs/             # Pointers to commits (branches, tags)
│   ├── heads/        # Local branch references
│   ├── tags/         # Tag references
│   └── remotes/      # Remote branch references
├── index             # Staging area (binary file)
└── logs/             # Reference log (reflog)
    ├── HEAD
    └── refs/
```

## Git Object Types

Git stores everything as objects. There are four object types:

### 1. Blob (Binary Large Object)

Stores file contents. No metadata, just raw data.

```bash
# Create a blob
echo "Hello, Git!" | git hash-object -w --stdin
# Output: 8d0e41234567890abcdef1234567890abcdef12
```

### 2. Tree

Represents a directory. Contains pointers to blobs and other trees.

```bash
# View tree contents
git ls-tree HEAD
# Output: 100644 blob abc123...  README.md
#         040000 tree def456...  src/
```

### 3. Commit

Stores a snapshot with metadata:
- Tree pointer (snapshot of files)
- Parent commit(s)
- Author info
- Committer info
- Commit message
- Timestamp

```bash
# View commit object
git cat-file -p HEAD
# Output: tree abc123...
#         parent def456...
#         author Name <email> timestamp
#         committer Name <email> timestamp
#         
#         Commit message
```

### 4. Tag (Annotated)

Stores tag metadata pointing to a commit.

```bash
# View tag object
git cat-file -p v1.0.0
# Output: object abc123...
#         type commit
#         tag v1.0.0
#         tagger Name <email> timestamp
#         
#         Tag message
```

## Object Storage

### How Objects are Stored

```bash
# Calculate SHA-1 hash
echo "Hello, Git!" | git hash-object --stdin
# Output: 8d0e41234567890abcdef1234567890abcdef12

# Store object
echo "Hello, Git!" | git hash-object -w --stdin
# Creates .git/objects/8d/0e41234567890abcdef1234567890abcdef12
```

### Pack Files

Git compresses objects into pack files for efficiency:

```bash
# Pack objects
git gc

# View pack files
ls .git/objects/pack/
# Output: pack-abc123.idx  pack-abc123.pack
```

## References (Refs)

References are pointers to commits:

```bash
# View branch reference
cat .git/refs/heads/main
# Output: abc123def456...

# View tag reference
cat .git/refs/tags/v1.0.0
# Output: abc123def456...
```

### HEAD

Special reference that points to:
- A branch name (attached HEAD)
- A commit hash (detached HEAD)

```bash
# View HEAD
cat .git/HEAD
# Output: ref: refs/heads/main

# Detach HEAD
git checkout abc123
cat .git/HEAD
# Output: abc123def456...
```

## The Index (Staging Area)

The index is a binary file that stores:
- List of files in the staging area
- File metadata (permissions, timestamps)
- SHA-1 hashes of file contents

```bash
# View index contents
git ls-files --stage
# Output: 100644 abc123 0  README.md
#         100644 def456 0  src/index.js
```

## Git Commands Under the Hood

### git add

```bash
# Creates blob and updates index
git add file.txt
# Equivalent to:
git hash-object -w file.txt  # Create blob
git update-index --add file.txt  # Update index
```

### git commit

```bash
# Creates tree and commit objects
git commit -m "message"
# Equivalent to:
git write-tree  # Create tree from index
git commit-tree HEAD^{tree} -p HEAD -m "message"  # Create commit
git update-ref refs/heads/main <commit-hash>  # Update branch
```

### git checkout

```bash
# Updates working directory and HEAD
git checkout main
# Equivalent to:
git symbolic-ref HEAD refs/heads/main  # Update HEAD
git checkout-index -a -f  # Update working directory
```

## SHA-1 Hashing

Git uses SHA-1 for:
- Object identification
- Integrity checking
- Branch and tag references

```bash
# Calculate SHA-1
echo "Hello" | sha1sum
# Output: 334ffc15c4849454e32a8c8a330f01c6d5130121  -

# Git's internal SHA-1
echo -n "Hello" | git hash-object --stdin
# Output: 334ffc15c4849454e32a8c8a330f01c6d5130121
```

## Reflog

The reference log tracks all changes to refs:

```bash
# View reflog
git reflog
# Output: abc123 HEAD@{0}: commit: Add feature
#         def456 HEAD@{1}: checkout: moving from main to feature
#         ghi789 HEAD@{2}: commit: Initial commit

# View specific reflog
git reflog show main
```

### Using Reflog to Recover

```bash
# Find lost commit
git reflog

# Recover
git checkout abc123

# Or reset branch
git reset --hard abc123
```

## Config Storage

Git configuration is stored in files:

```bash
# System config
cat /etc/gitconfig

# User config
cat ~/.gitconfig

# Repository config
cat .git/config
```

## Example: Anatomy of a Commit

```bash
# Create a commit
echo "Hello" > file.txt
git add file.txt
git commit -m "Initial commit"

# Inspect the commit
git cat-file -p HEAD
# Output:
# tree abc123def456...
# author Name <email> 1234567890 +0000
# committer Name <email> 1234567890 +0000
#
# Initial commit

# Inspect the tree
git cat-file -p HEAD^{tree}
# Output:
# 100644 blob 8901234567890123456789012345678901234567  file.txt

# Inspect the blob
git cat-file -p 8901234567890123456789012345678901234567
# Output:
# Hello
```

## Further Reading

- [Git Internals Book](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects)
- [Git Source Code](https://github.com/git/git)
- [Git Wiki](https://github.com/git/git/wiki)
