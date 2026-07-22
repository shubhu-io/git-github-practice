---
title: Git Performance
---
# Git Performance Guide

Optimize Git for speed and efficiency.

## Why Git Can Be Slow

- Large repositories
- Too many files
- Binary files in history
- Deep directory structures
- Network issues

## Speed Up Git Commands

### 1. Use Shallow Clone

```bash
# Clone with limited history
git clone --depth 1 https://github.com/user/repo.git

# Clone specific branch only
git clone --branch main --single-branch https://github.com/user/repo.git

# Later, get full history if needed
git fetch --unshallow
```

### 2. Enable Parallel Operations

```bash
# Parallel fetch
git config --global fetch.parallel 4

# Parallel checkout
git config --global checkout.parallel 4

# Parallel index
git config --global core.indexThreads 4
```

### 3. Use Sparse Checkout

```bash
# Enable sparse checkout
git sparse-checkout init --cone

# Only get specific directories
git sparse-checkout set src/ docs/

# Update sparse checkout
git sparse-checkout disable
```

### 4. Optimize Repository

```bash
# Garbage collection
git gc --aggressive --prune=now

# Repack objects
git repack -a -d --depth=250 --window=250

# Remove unreachable objects
git reflog expire --expire=now --all
git gc --prune=now
```

### 5. Use Local Cache

```bash
# Keep fetched data local
git config --global fetch.prune true
git config --global fetch.pruneTags true

# Reuse recorded resolution
git config --global rerere.enabled true
```

## Speed Up Specific Commands

### git status

```bash
# Use status in untracked mode
git status --untracked-files=no

# Or use short status
git status -s
```

### git log

```bash
# Limit output
git log -10

# Use oneline format
git log --oneline

# Skip file content
git log --no-abbrev-commit
```

### git diff

```bash
# Use stat only
git diff --stat

# Use name-only
git diff --name-only

# Use minimal context
git diff -U0
```

### git add

```bash
# Add specific files only
git add src/file.js

# Interactive mode (slow for large repos)
git add -p
```

## Handle Large Repositories

### 1. Git LFS (Large File Storage)

```bash
# Install Git LFS
git lfs install

# Track large files
git lfs track "*.psd"
git lfs track "*.zip"
git lfs track "*.mp4"

# Check tracked files
git lfs ls-files
```

### 2. Filter History

```bash
# Remove large files from history
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch large-file.zip" \
  --prune-empty --tag-name-filter cat -- --all

# Or use BFG (faster)
bfg --strip-blobs-bigger-than 10M
```

### 3. Split Repository

```bash
# Convert to monorepo with submodules
git submodule add https://github.com/user/lib.git libs/lib

# Or use subtrees
git subtree add --prefix=libs/lib https://github.com/user/lib.git main
```

## Optimize Git Configuration

### Add to ~/.gitconfig

```ini
[core]
    # Increase compression
    compression = 9
    
    # Use fscache for faster stats
    fscache = true

[feature]
    # Enable multi-pack index
    manyFiles = true

[index]
    # Use multi-pack index
    version = 4

[gc]
    # Auto-gc
    auto = 256

[fetch]
    # Parallel fetch
    parallel = 4

[pull]
    # Use rebase by default
    rebase = true

[rerere]
    # Reuse recorded resolution
    enabled = true

[diff]
    # Use histogram algorithm
    algorithm = histogram

[merge]
    # Use histogram algorithm
    algorithm = histogram
```

## Monitor Performance

### Enable Trace

```bash
# Time git commands
GIT_TRACE=1 git status

# Enable performance statistics
GIT_TRACE_PERFORMANCE=1 git status

# Enable performance stats for specific commands
git -c trace2.event=true -c trace2.perf=true status
```

### Check Repository Size

```bash
# Check .git size
du -sh .git

# Check largest files
git rev-list --objects --all | \
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
  sed -n 's/^blob //p' | sort -rnk2 | head -20

# Check pack files
ls -lh .git/objects/pack/
```

## Network Optimization

### Use SSH Instead of HTTPS

```bash
# Change remote to SSH
git remote set-url origin git@github.com:user/repo.git
```

### Enable HTTP/2

```bash
# Use HTTP/2 for faster transfers
git config --global http.version HTTP/2
```

### Use Compression

```bash
# Enable compression
git config --global core.compression 9

# Set HTTP compression
git config --global http.postBuffer 524288000
```

## Best Practices

1. **Keep commits small** - Easier to process
2. **Use .gitignore** - Don't track unnecessary files
3. **Regular cleanup** - Run `git gc` periodically
4. **Use Git LFS** - For large binary files
5. **Shallow clones** - For CI/CD
6. **Sparse checkout** - For large monorepos
7. **Parallel operations** - Speed up fetch/push
8. **Monitor performance** - Find bottlenecks

## Resources

- [Git Performance](https://git-scm.com/book/en/v2/Git-Internals-Maintenance-and-Data-Recovery)
- [Git LFS](https://git-lfs.github.com/)
- [Git Sparse Checkout](https://git-scm.com/docs/git-sparse-checkout)
