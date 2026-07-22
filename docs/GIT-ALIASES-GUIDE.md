# Git Aliases Guide

A comprehensive guide to useful Git aliases.

## What are Git Aliases?

Git aliases are shortcuts for longer Git commands. They help you work faster and remember commands more easily.

## Setting Up Aliases

### Global Aliases (Recommended)
```bash
git config --global alias.<alias-name> '<command>'
```

### Repository Aliases
```bash
git config alias.<alias-name> '<command>'
```

## Essential Aliases

### Status Aliases
```bash
git config --global alias.st status
git config --global alias.s status
git config --global alias.ss "status -s"
```

**Usage:**
```bash
git st    # Same as git status
git s     # Same as git status
git ss    # Short status format
```

### Branch Aliases
```bash
git config --global alias.br branch
git config --global alias.b branch
git config --global alias.bd "branch -d"
git config --global alias.bD "branch -D"
```

**Usage:**
```bash
git br         # List branches
git bd feature # Delete branch (safe)
git bD feature # Force delete branch
```

### Checkout Aliases
```bash
git config --global alias.co checkout
git config --global alias.sw switch
git config --global alias.cb "checkout -b"
```

**Usage:**
```bash
git co main        # Switch to main
git sw main        # Switch to main (modern)
git cb feature     # Create and switch to branch
```

### Commit Aliases
```bash
git config --global alias.cm commit
git config --global alias.ci commit
git config --global alias.ca "commit --amend"
git config --global alias.cam "commit --amend --no-edit"
```

**Usage:**
```bash
git cm -m "message"    # Commit with message
git ci -m "message"    # Commit with message
git ca -m "new msg"    # Amend last commit message
git cam                # Amend last commit (keep message)
```

### Add Aliases
```bash
git config --global alias.aa "add --all"
git config --global alias.ap "add -p"
git config --global alias.a add
```

**Usage:**
```bash
git aa        # Stage all changes
git ap        # Interactive staging (patch mode)
git a .       # Stage all changes
git a file    # Stage specific file
```

### Diff Aliases
```bash
git config --global alias.df diff
git config --global alias.dfc "diff --cached"
git config --global alias.dfh "diff HEAD"
git config --global alias.dfw "diff --word-diff"
```

**Usage:**
```bash
git df        # Show unstaged changes
git dfc       # Show staged changes
git dfh       # Show all changes vs last commit
git dfw       # Show word diff
```

### Log Aliases
```bash
git config --global alias.lg "log --oneline --graph --all --decorate"
git config --global alias.lg2 "log --oneline --graph --decorate"
git config --global alias.ls "log --oneline -10"
git config --global alias.ll "log --pretty=format:'%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate --numstat"
git config --global alias.lg1 "log --oneline --graph"
```

**Usage:**
```bash
git lg      # Visual log with all branches
git lg2     # Visual log current branch
git ls      # Last 10 commits
git ll      # Detailed log with stats
git lg1     # Simple graph log
```

### Pull Aliases
```bash
git config --global alias.pl "pull --rebase"
git config --global alias.pu "push"
git config --global alias.pus "push"
```

**Usage:**
```bash
git pl          # Pull with rebase (cleaner history)
git pu origin main  # Push to origin main
```

### Stash Aliases
```bash
git config --global alias.stp "stash pop"
git config --global alias.stl "stash list"
git config --global alias.sta "stash apply"
git config --global alias.stc "stash clear"
```

**Usage:**
```bash
git stp    # Pop most recent stash
git stl    # List all stashes
git sta    # Apply most recent stash
git stc    # Clear all stashes
```

### Remote Aliases
```bash
git config --global alias.rv "remote -v"
git config --global alias.fet "fetch --all --prune"
git config --global alias.pf "push --force-with-lease"
```

**Usage:**
```bash
git rv          # List remotes
git fet         # Fetch all remotes and prune
git pf          # Safe force push
```

### Cleanup Aliases
```bash
git config --global alias.cleanup "!git branch --merged | grep -v '\\*\\|main\\|master' | xargs -n 1 git branch -d"
git config --global alias.aliases "!git config --global --list | grep alias"
```

**Usage:**
```bash
git cleanup      # Delete merged branches
git aliases      # List all aliases
```

### Undo Aliases
```bash
git config --global alias.undo "reset HEAD~1 --soft"
git config --global alias.undo-hard "reset --hard HEAD~1"
git config --global alias.amend "commit --amend --no-edit"
```

**Usage:**
```bash
git undo          # Soft reset last commit
git undo-hard     # Hard reset last commit (DANGEROUS)
git amend         # Amend last commit message
```

## Advanced Aliases

### Find Large Files
```bash
git config --global alias.large "!git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | sed -n 's/^blob //p' | sort -rnk2 | head -20"
```

### Show Repository Stats
```bash
git config --global alias.stats "!echo 'Commits:' && git rev-list --all --count && echo 'Contributors:' && git shortlog -sn --all | wc -l"
```

### Quick Add and Commit
```bash
git config --global alias.ac "!git add -A && git commit -m"
```

**Usage:**
```bash
git ac "feat: add new feature"    # Stage all and commit
```

### Show Files in Last Commit
```bash
git config --global alias.lastfiles "diff --name-only HEAD~1 HEAD"
```

### Show Last Commit Details
```bash
git config --global alias.last "log -1 HEAD --stat"
```

## Complete Alias Setup Script

```bash
#!/bin/bash
# Git Aliases Setup

# Status
git config --global alias.st status
git config --global alias.s status
git config --global alias.ss "status -s"

# Branch
git config --global alias.br branch
git config --global alias.b branch
git config --global alias.bd "branch -d"
git config --global alias.bD "branch -D"

# Checkout
git config --global alias.co checkout
git config --global alias.sw switch
git config --global alias.cb "checkout -b"

# Commit
git config --global alias.cm commit
git config --global alias.ci commit
git config --global alias.ca "commit --amend"
git config --global alias.cam "commit --amend --no-edit"

# Add
git config --global alias.aa "add --all"
git config --global alias.ap "add -p"

# Diff
git config --global alias.df diff
git config --global alias.dfc "diff --cached"
git config --global alias.dfh "diff HEAD"

# Log
git config --global alias.lg "log --oneline --graph --all --decorate"
git config --global alias.ls "log --oneline -10"
git config --global alias.last "log -1 HEAD --stat"

# Pull/Push
git config --global alias.pl "pull --rebase"
git config --global alias.pu push
git config --global alias.psf "push --force-with-lease"

# Stash
git config --global alias.stp "stash pop"
git config --global alias.stl "stash list"
git config --global alias.sta "stash apply"

# Cleanup
git config --global alias.cleanup "!git branch --merged | grep -v '\\*\\|main\\|master' | xargs -n 1 git branch -d"

# Undo
git config --global alias.undo "reset HEAD~1 --soft"
git config --global alias.undo-hard "reset --hard HEAD~1"

echo "Git aliases configured!"
```

## Managing Aliases

### List All Aliases
```bash
git config --global --list | grep alias
```

### Remove an Alias
```bash
git config --global --unset alias.<alias-name>
```

### Remove All Aliases
```bash
git config --global --remove-section alias
```

## Tips

1. **Start simple** - Add 2-3 aliases at a time
2. **Use meaningful names** - Make aliases easy to remember
3. **Keep them consistent** - Use similar patterns
4. **Document your aliases** - Keep a list somewhere
5. **Share with your team** - Create a shared alias file

## Resources

- [Git Documentation](https://git-scm.com/docs/git-config)
- [GitHub Aliases Guide](https://github.com/git/git/blob/master/Documentation/GitAliases.txt)
