---
layout: single
title: Troubleshooting
---
# Git Troubleshooting Guide

Common Git problems and their solutions.

---

## Table of Contents

1. [Merge Conflicts](#merge-conflicts)
2. [Undoing Mistakes](#undoing-mistakes)
3. [Authentication Issues](#authentication-issues)
4. [Performance Issues](#performance-issues)
5. [Repository Issues](#repository-issues)
6. [Branch Issues](#branch-issues)
7. [Commit Issues](#commit-issues)

---

## Merge Conflicts

### Problem: Merge conflict during merge/rebase

**Symptoms:**
```
CONFLICT (content): Merge conflict in file.txt
Automatic merge failed; fix conflicts and then commit the result.
```

**Solution:**
```bash
# 1. Open the conflicted file and look for conflict markers:
<<<<<<< HEAD
Your changes
=======
Incoming changes
>>>>>>> feature-branch

# 2. Edit the file to resolve the conflict
# Remove the conflict markers and keep the desired code

# 3. Stage the resolved file
git add file.txt

# 4. Complete the merge
git commit

# OR if rebasing:
git rebase --continue
```

### Problem: Want to abort a merge

```bash
git merge --abort
```

### Problem: Want to abort a rebase

```bash
git rebase --abort
```

---

## Undoing Mistakes

### Problem: Discard changes in working directory

```bash
# Discard changes to specific file
git restore file.txt

# Discard all changes
git restore .
```

### Problem: Unstage a file

```bash
# Unstage specific file
git restore --staged file.txt

# Unstage all files
git restore --staged .
```

### Problem: Undo last commit (keep changes)

```bash
git reset HEAD~1
```

### Problem: Undo last commit (discard changes)

```bash
# WARNING: This is destructive!
git reset --hard HEAD~1
```

### Problem: Undo a pushed commit (safe)

```bash
git revert HEAD
```

### Problem: Amend last commit message

```bash
git commit --amend -m "New commit message"
```

### Problem: Add forgotten file to last commit

```bash
git add forgotten-file.txt
git commit --amend --no-edit
```

---

## Authentication Issues

### Problem: Permission denied (publickey)

```bash
# Check if SSH key is loaded
ssh-add -l

# Add SSH key
ssh-add ~/.ssh/id_rsa

# Test SSH connection
ssh -T git@github.com
```

### Problem: Remote authentication failed

```bash
# If using HTTPS, update credentials
git config --global credential.helper store

# Or use GitHub CLI
gh auth login
```

### Problem: Token expired (GitHub)

```bash
# Generate new token on GitHub
# Settings > Developer settings > Personal access tokens

# Update remote URL with new token
git remote set-url origin https://<token>@github.com/user/repo.git
```

---

## Performance Issues

### Problem: Repository is slow

```bash
# Clean up repository
git gc --aggressive --prune=now

# Remove unreachable objects
git reflog expire --expire=now --all
git gc --prune=now
```

### Problem: Large files in history

```bash
# Find large files
git rev-list --objects --all | \
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
  sed -n 's/^blob //p' | sort -rnk2 | head -20

# Use Git LFS for large files
git lfs install
git lfs track "*.psd"
git lfs track "*.zip"
```

### Problem: Slow clone

```bash
# Shallow clone (limited history)
git clone --depth 1 https://github.com/user/repo.git

# Clone specific branch only
git clone --branch main --single-branch https://github.com/user/repo.git
```

---

## Repository Issues

### Problem: Repository corrupted

```bash
# Check repository integrity
git fsck --full

# Fix corrupted objects
git fsck --full --strict
```

### Problem: Wrong remote URL

```bash
# Check current remote
git remote -v

# Update remote URL
git remote set-url origin https://github.com/user/repo.git

# Add new remote
git remote add upstream https://github.com/original/repo.git

# Remove remote
git remote remove upstream
```

### Problem: Detached HEAD

```bash
# You're in detached HEAD state
git checkout main
# or
git switch main
```

---

## Branch Issues

### Problem: Branch already exists

```bash
# Delete local branch
git branch -d branch-name

# Force delete
git branch -D branch-name

# Delete remote branch
git push origin --delete branch-name
```

### Problem: Rename branch

```bash
# Rename current branch
git branch -m new-name

# Rename specific branch
git branch -m old-name new-name
```

### Problem: Track remote branch

```bash
# Set upstream for current branch
git branch --set-upstream-to=origin/branch-name

# Or when pushing
git push -u origin branch-name
```

### Problem: Delete remote branch

```bash
git push origin --delete branch-name
# or
git push origin :branch-name
```

---

## Commit Issues

### Problem: Commit to wrong branch

```bash
# Save commits to temp area
git stash

# Switch to correct branch
git checkout correct-branch

# Apply commits
git stash pop

# Or cherry-pick specific commits
git cherry-pick <commit-hash>
```

### Problem: Wrong commit message

```bash
# Only if not pushed yet
git commit --amend -m "Correct message"

# If already pushed
git commit --amend -m "Correct message"
git push --force-with-lease
```

### Problem: Want to undo a specific commit

```bash
# Find the commit
git log --oneline

# Revert specific commit
git revert <commit-hash>
```

### Problem: Squash commits

```bash
# Interactive rebase
git rebase -i HEAD~3

# In editor:
# pick abc1234 First commit
# squash def5678 Second commit
# squash ghi9012 Third commit
```

---

## Useful Commands

### Find what changed in a commit

```bash
git show <commit-hash>
git show --stat <commit-hash>
```

### Search for a string in history

```bash
git log -S "string" --oneline
git log -G "regex" --oneline
```

### Find which commit introduced a bug

```bash
git bisect start
git bisect bad          # Current commit is bad
git bisect good abc1234 # This commit was good
# Git checks out middle commit - test it
git bisect good # or git bisect bad
# Repeat until Git finds the commit
git bisect reset
```

### View file history

```bash
git log --follow -p file.txt
git log --oneline --follow file.txt
```

### Find who changed a line

```bash
git blame file.txt
```

---

## Getting Help

```bash
# General help
git help
git help <command>

# Command-specific help
git help commit
git help merge
git help rebase

# Quick reference
git <command> --help
```

---

## Additional Resources

- [Git Official Documentation](https://git-scm.com/doc)
- [GitHub Help](https://help.github.com/)
- [Git Immersion](https://gitimmersion.com/)
- [Learn Git Branching](https://learngitbranching.js.org/)
