# Advanced Exercise 20: Git Performance Optimization

## Objective
Optimize Git performance for large repositories.

## Instructions

### Step 1: Enable Performance Features

```bash
# Enable multi-pack index
git config --global core.multiPackIndex true

# Enable commit graph
git config core.commitGraph true
git gc --write-commit-graph

# Enable parallel index preload
git config --global feature.manyFiles true
```

### Step 2: Analyze Repository Size

```bash
# Check overall size
du -sh .git

# Find large files
git rev-list --objects --all | \
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
  sed -n 's/^blob //p' | sort -rnk2 | head -20

# Check pack files
git count-objects -vH
```

### Step 3: Clean Up History

```bash
# Remove large files from history
# WARNING: This rewrites history!
git filter-repo --path-glob '*.zip' --invert-paths
git filter-repo --path-glob '*.psd' --invert-paths

# Or use BFG
java -jar bfg.jar --strip-blobs-bigger-than 10M repo.git
```

### Step 4: Optimize Storage

```bash
# Repack objects
git repack -a -d --depth=250 --window=250

# Prune old objects
git gc --prune=now

# Check for corruption
git fsck --full
```

## Challenge

1. Set up shallow clone for CI/CD
2. Configure sparse checkout for large repo
3. Benchmark before and after optimization

## Key Concepts

- Git can be slow with large repos
- `gc` cleans up old objects
- `filter-repo` rewrites history
- Shallow clones save space and time

## Solution

<details>
<summary>Solution</summary>

```bash
# Shallow clone for CI
git clone --depth 1 --single-branch https://github.com/user/repo.git

# Sparse checkout
git clone --filter=blob:none --no-checkout https://github.com/user/repo.git
cd repo
git sparse-checkout init --cone
git sparse-checkout set src/ docs/

# Benchmark
time git clone https://github.com/user/repo.git repo-normal
time git clone --depth 1 https://github.com/user/repo.git repo-shallow
```

</details>
