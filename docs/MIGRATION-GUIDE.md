# Migration Guide

Migrating from other version control systems to Git.

## From SVN to Git

### Step 1: Install Tools

```bash
# Install git-svn
# On macOS
brew install git-svn

# On Linux
sudo apt-get install git-svn
```

### Step 2: Clone SVN Repository

```bash
# Basic migration
git svn clone https://svn.example.com/repo

# With authors file
git svn clone https://svn.example.com/repo --authors-file=authors.txt

# With specific trunk/branches structure
git svn clone https://svn.example.com/repo \
  --trunk=trunk \
  --branches=branches \
  --tags=tags
```

### Step 3: Create Authors File

```bash
# authors.txt format:
# svnusername = Git Name <email@example.com>
admin = Admin User <admin@example.com>
developer = Dev User <dev@example.com>
```

### Step 4: Fetch All History

```bash
cd repo
git svn fetch
```

### Step 5: Convert Branches and Tags

```bash
# Convert branches
for branch in $(git branch -r | grep -v tags | sed 's/origin\///'); do
    git branch $branch refs/remotes/origin/$branch
done

# Convert tags
for tag in $(git branch -r | grep tags | sed 's/origin\/tags\///'); do
    git tag $tag refs/remotes/origin/tags/$tag
done
```

### Step 6: Push to Git

```bash
# Add remote
git remote add origin https://github.com/user/repo.git

# Push all branches
git push origin --all

# Push all tags
git push origin --tags
```

## From Mercurial to Git

### Step 1: Install Tools

```bash
# Install hg-git
pip install hg-git
```

### Step 2: Configure Mercurial

```ini
# .hgrc
[extensions]
hggit =

[hggit]
pushed = outgoing
```

### Step 3: Convert Repository

```bash
# Clone and convert
hg clone https://hg.example.com/repo
cd repo

# Push to Git
hg bookmark -r default master
hg push git+ssh://git@github.com/user/repo.git
```

## From CVS to Git

### Step 1: Install Tools

```bash
# Install cvs-fast-export
# On macOS
brew install cvs-fast-export

# On Linux
sudo apt-get install cvs-fast-export
```

### Step 2: Export CVS

```bash
# Export CVS repository
cvsps -A authors.txt -x -d /path/to/cvs/repo > /tmp/cvsps.log

# Convert to Git
cvsimport -v -d /path/to/cvs/repo
```

## From Perforce to Git

### Step 1: Install Tools

```bash
# Install git-p4
# Usually included with Git
```

### Step 2: Clone Perforce

```bash
# Clone depot
git p4 clone //depot/path@all

# Or specific changelist
git p4 clone //depot/path@12345
```

### Step 3: Sync Changes

```bash
# Fetch new changes
git p4 sync

# Submit changes
git p4 submit
```

## From TFS to Git

### Step 1: Install Tools

```bash
# Install git-tfs
# On Windows
choco install gittfs

# On macOS/Linux
brew install git-tfs
```

### Step 2: Clone TFS

```bash
# Clone entire history
git tfs clone https://tfs.example.com/tfs/Collection $/Project

# With specific branch
git tfs quick-clone --branches https://tfs.example.com/tfs/Collection $/Project
```

### Step 3: Push to Git

```bash
# Add remote
git remote add origin https://github.com/user/repo.git

# Push
git push origin --all
```

## Tips for Migration

### Preserve History

1. **Use authors file** - Map usernames correctly
2. **Fetch all branches** - Don't lose any work
3. **Convert tags** - Preserve milestones
4. **Verify results** - Check history looks right

### Handle Large Repos

1. **Use shallow clone** - Start with recent history
2. **Filter large files** - Use git-lfs
3. **Split repository** - Consider multiple repos
4. **Test performance** - Ensure Git works well

### Coordinate with Team

1. **Announce migration** - Give team notice
2. **Provide training** - Help team learn Git
3. **Freeze old repo** - Prevent old commits
4. **Monitor issues** - Help with problems

## Common Issues

### Lost History

```bash
# Check if history is complete
git log --oneline | wc -l

# Compare with SVN
svn log https://svn.example.com/repo | wc -l
```

### Wrong Authors

```bash
# Fix author names
git filter-branch --env-filter '
    if [ "$GIT_AUTHOR_NAME" = "oldname" ]; then
        export GIT_AUTHOR_NAME="New Name"
        export GIT_AUTHOR_EMAIL="new@email.com"
    fi
' -- --all
```

### Large Files

```bash
# Find large files
git rev-list --objects --all | \
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
  sed -n 's/^blob //p' | sort -rnk2 | head -20

# Move to git-lfs
git lfs migrate import --include="*.zip,*.psd" --everything
```

## Resources

- [git-svn Documentation](https://git-scm.com/docs/git-svn)
- [git-tfs Documentation](https://github.com/git-tfs/git-tfs)
- [hg-git Documentation](https://hg-git.readthedocs.io/)
