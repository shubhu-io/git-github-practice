---
layout: single
title: Complete Git & GitHub Guide
---
# Git & GitHub Complete Learning Guide

## TABLE OF CONTENTS

1. [Git Basics](#1-git-basics)
2. [Branching & Merging](#2-branching--merging)
3. [Undoing Mistakes](#3-undoing-mistakes)
4. [Stashing Changes](#4-stashing-changes)
5. [Remote Repositories](#5-remote-repositories)
6. [GitHub Workflow](#6-github-workflow)
7. [GitHub Actions](#7-github-actions)
8. [Advanced Commands](#8-advanced-commands)

---

## 1. GIT BASICS

### What is Git?
Git is a **distributed version control system**. It tracks changes in your code over time so you can recall specific versions later.

### Setting Up (First Time Only)
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --list              # Verify settings
```

### Initializing a Repository
```bash
mkdir my-project
cd my-project
git init                        # Creates .git folder
```
After `git init`, Git starts tracking this folder.

### The 3 Areas of Git
```
Working Directory  -->  Staging Area  -->  Repository
   (your files)       (git add)          (git commit)
```

- **Working Directory**: Your actual files on disk
- **Staging Area**: A middle ground where you prepare changes
- **Repository (.git)**: The permanent history of all commits

### Checking Status
```bash
git status                     # See what's modified/staged/untracked
```

### Staging Files
```bash
git add file.txt               # Stage one file
git add src/                   # Stage entire folder
git add .                      # Stage everything
git add *.js                   # Stage all JS files
git reset file.txt             # Unstage a file
```

### Committing
```bash
git commit -m "message"        # Commit staged files
git commit -am "message"       # Stage ALL tracked files + commit
```

### Commit Message Rules
- Use present tense: "Add feature" not "Added feature"
- Keep under 72 characters
- Be specific about WHAT changed and WHY

### Viewing History
```bash
git log                        # Full detailed log
git log --oneline              # One line per commit
git log --oneline --graph      # Visual branch graph
git log -5                     # Last 5 commits
git log --author="John"        # Filter by author
git log --since="2024-01-01"   # Filter by date
```

### Viewing Changes
```bash
git diff                       # Unstaged changes
git diff --staged              # Staged changes
git diff HEAD                  # All changes vs last commit
git diff branch1..branch2      # Compare branches
git show abc1234               # Show a specific commit
```

---

## 2. BRANCHING & MERGING

### What is a Branch?
A branch is an independent line of development. You can work on features without affecting the main code.

### Branch Commands
```bash
git branch                     # List all branches (* = current)
git branch feature-login       # Create a new branch
git checkout feature-login     # Switch to branch
git switch feature-login       # Same as checkout (modern)
git checkout -b feature-login  # Create + Switch (most common)
git switch -c feature-login    # Same as above (modern)
git branch -d feature-login    # Delete (safe - checks merged)
git branch -D feature-login    # Force delete (even unmerged)
git branch -m old-name new     # Rename branch
```

### Typical Workflow
```bash
# 1. You're on main branch
git checkout main

# 2. Create feature branch
git checkout -b feature/new-button

# 3. Work on your feature
# ... edit files ...

# 4. Commit your changes
git add .
git commit -m "feat: add new button component"

# 5. Push branch to GitHub
git push -u origin feature/new-button

# 6. Switch back to main
git checkout main

# 7. Pull latest changes
git pull

# 8. Merge your feature
git merge feature/new-button

# 9. Delete the feature branch
git branch -d feature/new-button
```

### Merging
```bash
git merge feature-branch       # Merge into current branch
git merge --abort              # Cancel a merge (if conflicts)
```

### Merge Conflicts
When Git can't automatically merge changes, you get a conflict:

```
<<<<<<< HEAD (current change)
const color = "blue";
=======
const color = "red";
>>>>>>> feature-branch (incoming change)
```

**How to resolve:**
1. Open the file and find the conflict markers
2. Choose which version to keep (or combine both)
3. Remove the `<<<<<<<`, `=======`, `>>>>>>>` markers
4. Save the file
5. Stage and commit:
```bash
git add .
git commit -m "fix: resolve merge conflict in color config"
```

---

## 3. UNDOING MISTAKES

### Scenario: "I want to discard working changes"
```bash
git restore file.txt            # Discard changes to one file
git restore .                   # Discard ALL unstaged changes
```

### Scenario: "I want to unstage a file"
```bash
git restore --staged file.txt   # Unstage but keep changes
git restore --staged .          # Unstage everything
```

### Scenario: "I want to undo my last commit"
```bash
# Keep changes in working directory (most common)
git reset HEAD~1

# Discard changes completely (DANGEROUS!)
git reset --hard HEAD~1

# Create a NEW commit that undoes the last one (SAFE for shared)
git revert HEAD
```

### Scenario: "I want to go back to a specific commit"
```bash
git log --oneline                # Find the commit hash
git checkout abc1234             # Detach HEAD (view old code)
git checkout main                # Return to latest

# Actually reset to that commit
git reset --hard abc1234
```

### Scenario: "I want to amend my last commit"
```bash
git commit --amend -m "new message"           # Change message
git add forgotten-file.txt
git commit --amend --no-edit                  # Add forgotten file
```

### Summary Table
| Situation | Command | Safe? |
|-----------|---------|-------|
| Discard working changes | `git restore <file>` | Yes |
| Unstage a file | `git restore --staged <file>` | Yes |
| Undo commit, keep changes | `git reset HEAD~1` | Yes |
| Undo commit, discard changes | `git reset --hard HEAD~1` | **NO** |
| Undo pushed commit | `git revert <hash>` | Yes |
| Change last commit message | `git commit --amend` | Yes (local only) |

---

## 4. STASHING CHANGES

Stashing saves uncommitted changes temporarily so you can switch tasks.

```bash
git stash                      # Stash changes
git stash save "WIP: login"    # Stash with a message
git stash list                 # See all stashes
git stash pop                  # Apply + remove stash
git stash apply                # Apply but keep stash
git stash drop                 # Delete most recent stash
git stash clear                # Delete all stashes
git stash pop stash@{2}        # Apply specific stash
```

### Common Scenario
```bash
# You're working on feature A but need to fix a bug
git stash save "WIP: feature A"
git checkout main
git checkout -b bugfix/issue-42
# ... fix the bug ...
git add . && git commit -m "fix: resolve issue #42"
git checkout main && git merge bugfix/issue-42

# Go back to your feature
git checkout feature/new-button
git stash pop
```

---

## 5. REMOTE REPOSITORIES

### Connecting to GitHub
```bash
git remote add origin https://github.com/user/repo.git
git remote -v                   # Verify remote URLs
```

### Pushing to GitHub
```bash
git push origin main            # Push main branch
git push origin feature-branch  # Push feature branch
git push -u origin main         # Push + set upstream (first time)
git push                        # Push (after upstream is set)
git push --force                # DANGEROUS: overwrites remote
git push --force-with-lease     # Safer force push
```

### Pulling from GitHub
```bash
git pull                        # Fetch + merge (git fetch + git merge)
git pull --rebase               # Fetch + rebase (cleaner history)
git fetch                       # Download changes without applying
```

### Fetch vs Pull
```
fetch = Download changes (safe, doesn't modify your files)
pull  = Download + apply changes (may cause merge conflicts)
```

### Removing Remote
```bash
git remote remove origin        # Disconnect from remote
```

---

## 6. GITHUB WORKFLOW

### Creating a Repository on GitHub
```bash
# Option 1: CLI
gh repo create my-repo --public

# Option 2: Web
# Go to github.com > New Repository
```

### Forking a Repository
1. Click "Fork" on GitHub
2. Clone YOUR fork:
```bash
git clone https://github.com/YOUR-USER/repo.git
```

### Pull Request (PR) Workflow
```bash
# 1. Create a branch
git checkout -b feature/my-feature

# 2. Make changes and commit
git add .
git commit -m "feat: add new feature"

# 3. Push to your fork
git push -u origin feature/my-feature

# 4. Create PR on GitHub (or use CLI)
gh pr create --title "Add new feature" --body "Description here"

# 5. Review feedback, make changes if needed
# 6. Merge the PR on GitHub
```

### Issue Workflow
```bash
# Create an issue
gh issue create --title "Bug: login broken" --body "Steps to reproduce..."

# List issues
gh issue list

# Close an issue (via commit message)
git commit -m "fix: resolve login issue, closes #5"
```

### GitHub CLI Commands
```bash
gh auth login                 # Authenticate with GitHub
gh repo create                # Create repository
gh pr create                  # Create pull request
gh pr list                    # List pull requests
gh pr merge                   # Merge a PR
gh issue create               # Create an issue
gh issue list                 # List issues
gh issue close                # Close an issue
```

---

## 7. GITHUB ACTIONS

### What are GitHub Actions?
Automation that runs when events happen on your repo (push, PR, schedule, etc.).

### Workflow File Location
`.github/workflows/<name>.yml`

### Basic Workflow
```yaml
name: CI

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: echo "Hello from GitHub Actions!"
```

### Real-World Example: Node.js CI
```yaml
name: Node CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [18.x, 20.x]

    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm ci
      - run: npm test
      - run: npm run build
```

### Key Concepts
- **Trigger**: When the workflow runs (`on: push, pull_request, schedule`)
- **Job**: A group of steps that run together
- **Step**: A single task (run a command or use an action)
- **Action**: Reusable units (`uses: actions/checkout@v4`)
- **Secrets**: Sensitive values (`${{ secrets.API_KEY }}`)
- **Matrix**: Test across multiple environments

---

## 8. ADVANCED COMMANDS

### Interactive Rebase (Clean Up History)
```bash
git rebase -i HEAD~5            # Edit last 5 commits
# Opens editor:
# pick   abc1234  First commit
# squash def5678  Second commit    <-- squash = combine with previous
# reword ghi9012  Third commit     <-- reword = change message
# drop   jkl3456  Bad commit       <-- drop = remove entirely
```

### Cherry-Pick (Grab Specific Commit)
```bash
git cherry-pick abc1234         # Apply specific commit to current branch
git cherry-pick abc1234..def5678 # Apply range of commits
```

### Tagging Releases
```bash
git tag v1.0.0                  # Create lightweight tag
git tag -a v1.0.0 -m "Release" # Create annotated tag
git push origin v1.0.0          # Push specific tag
git push origin --tags          # Push all tags
git tag -d v1.0.0               # Delete local tag
```

### Git Bisect (Find Bug)
```bash
git bisect start
git bisect bad                  # Current commit is bad
git bisect good abc1234         # This commit was good
# Git checks out middle commit - test it
git bisect good                 # or git bisect bad
# Repeat until Git finds the exact commit
git bisect reset                # Done
```

### Cleaning Untracked Files
```bash
git clean -n                    # Dry run - see what would be deleted
git clean -f                    # Force delete untracked files
git clean -fd                   # Delete untracked files AND directories
```

### Aliases (Speed Up Git)
```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm commit
git config --global alias.lg "log --oneline --graph --all"
```

Now you can type `git st` instead of `git status`, etc.

---

## COMMON WORKFLOW CHEAT SHEET

```
START NEW FEATURE:
  git checkout main
  git pull
  git checkout -b feature/name
  # work, work, work
  git add .
  git commit -m "feat: description"
  git push -u origin feature/name
  # create PR on GitHub
  # review & merge
  git checkout main && git pull
  git branch -d feature/name

FIX A BUG:
  git checkout main
  git pull
  git checkout -b bugfix/issue-name
  # fix the bug
  git add .
  git commit -m "fix: description"
  git push -u origin bugfix/issue-name
  # create PR, merge, clean up

EMERGENCY FIX (hotfix):
  git checkout main
  git checkout -b hotfix/critical-bug
  # fix immediately
  git add . && git commit -m "hotfix: critical bug"
  git push -u origin hotfix/critical-bug
  # merge ASAP
```
