# Common Git Scenarios

Real-world situations and how to handle them.

## Scenario 1: "I made a mistake and need to undo it"

### Undo changes to a file
```bash
# Discard changes (go back to last commit)
git restore filename.txt

# Discard all changes
git restore .
```

### Undo last commit (keep changes)
```bash
git reset HEAD~1
```

### Undo last commit (discard changes) - DANGEROUS
```bash
git reset --hard HEAD~1
```

### Undo a pushed commit (safe)
```bash
git revert HEAD
```

## Scenario 2: "I'm working on two things at once"

Use stashing:
```bash
# Save current work
git stash save "Working on feature A"

# Switch to fix a bug
git checkout main
git checkout -b bugfix/urgent

# Fix the bug, commit, merge
git checkout main
git merge bugfix/urgent

# Go back to your feature
git checkout feature/my-feature
git stash pop
```

## Scenario 3: "I need to try something without affecting my code"

Use branches:
```bash
# Create a safe branch
git checkout -b experiment

# Try risky changes
# ... make changes ...

# If it works, merge it
git checkout main
git merge experiment

# If it doesn't work, delete it
git branch -D experiment
```

## Scenario 4: "Someone else made changes I need"

```bash
# Get their changes
git pull origin main

# If there are conflicts, resolve them
# Edit the conflicted files
# Then commit
git add .
git commit -m "Resolve merge conflict"
```

## Scenario 5: "I committed but forgot a file"

```bash
# Add the forgotten file
git add forgotten-file.txt

# Amend the last commit
git commit --amend --no-edit
```

## Scenario 6: "I need to go back to an old version"

```bash
# See the history
git log --oneline

# Go to that version
git checkout abc1234

# Create a branch from there (optional)
git checkout -b old-version abc1234
```

## Scenario 7: "I need to split a big change into smaller commits"

```bash
# Add files one by one
git add file1.txt
git commit -m "Add file 1"

git add file2.txt
git commit -m "Add file 2"

git add file3.txt
git commit -m "Add file 3"
```

## Scenario 8: "I need to combine my last 3 commits"

```bash
# Interactive rebase
git rebase -i HEAD~3

# In the editor:
# Keep first as "pick"
# Change others to "squash"
```

## Scenario 9: "I accidentally deleted a branch"

```bash
# Find the commit hash
git reflog

# Recreate the branch
git checkout -b recovered-branch abc1234
```

## Scenario 10: "I need to work on a specific version"

```bash
# Find the tag or commit
git tag -l

# Checkout that version
git checkout v1.0.0

# Create a branch if needed
git checkout -b hotfix v1.0.0
```

## Scenario 11: "I need to see who changed what"

```bash
# See who last changed each line
git blame filename.txt

# See full history of a file
git log --follow -p filename.txt
```

## Scenario 12: "I need to find when a bug was introduced"

```bash
# Start bisect
git bisect start
git bisect bad          # Current commit is bad
git bisect good abc1234 # This commit was good

# Test each commit
# Mark as good or bad
git bisect good  # or git bisect bad

# When done
git bisect reset
```

## Scenario 13: "I need to share code without merging"

Use a patch:
```bash
# Create a patch
git format-patch -1 HEAD

# Apply the patch on another machine
git apply 0001-fix-bug.patch
```

## Scenario 14: "I need to collaborate on a fork"

```bash
# Fork on GitHub, then clone your fork
git clone https://github.com/YOUR-USERNAME/repo.git

# Add upstream
git remote add upstream https://github.com/ORIGINAL/repo.git

# Make changes
git checkout -b feature/new-thing
# ... make changes ...
git push origin feature/new-thing

# Create PR on GitHub
```

## Scenario 15: "I need to clean up my repository"

```bash
# Remove untracked files (preview first)
git clean -n

# Remove untracked files
git clean -f

# Remove untracked files and directories
git clean -fd

# Remove ignored files
git clean -Xf
```

## Quick Reference

| Situation | Command |
|-----------|---------|
| Undo changes | `git restore <file>` |
| Undo commit (keep) | `git reset HEAD~1` |
| Undo commit (lose) | `git reset --hard HEAD~1` |
| Undo pushed commit | `git revert <hash>` |
| Fix commit message | `git commit --amend` |
| Add forgotten file | `git add <file> && git commit --amend` |
| Save work temporarily | `git stash` |
| Get stashed work | `git stash pop` |
| Delete branch | `git branch -d <branch>` |
| Force delete branch | `git branch -D <branch>` |
| See history | `git log --oneline` |
| See changes | `git diff` |
| See who changed what | `git blame <file>` |
