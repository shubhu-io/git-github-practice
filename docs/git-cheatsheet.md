---
title: Git Cheatsheet
---
# Git & GitHub Cheat Sheet

<div class="svg-diagram">
<img src="{{ '/assets/images/svg/git-cheatsheet.svg' | relative_url }}" alt="Git Commands Cheat Sheet" style="max-width:100%; height:auto; margin: 20px 0;">
</div>

## Setup
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

## Creating Repos
```bash
git init                    # Initialize local repo
git clone <url>             # Clone remote repo
```

## Staging & Committing
```bash
git add <file>              # Stage a file
git add .                   # Stage all changes
git status                  # Check status
git commit -m "message"     # Commit staged files
git commit -am "message"    # Stage tracked files and commit
```

## Branching
```bash
git branch                  # List branches
git branch <name>           # Create branch
git checkout <branch>       # Switch branch
git checkout -b <branch>    # Create and switch
git switch <branch>         # Switch branch (modern)
git switch -c <branch>      # Create and switch (modern)
git branch -d <branch>      # Delete branch
git branch -D <branch>      # Force delete branch
```

## Merging
```bash
git merge <branch>          # Merge branch into current
git merge --abort           # Abort a merge
```

## Remote Operations
```bash
git remote add origin <url> # Add remote
git remote -v               # List remotes
git push origin <branch>    # Push to remote
git push -u origin <branch> # Push and set upstream
git pull                    # Fetch and merge
git fetch                   # Fetch without merging
```

## Stashing
```bash
git stash                   # Stash changes
git stash list              # List stashes
git stash pop               # Apply and remove stash
git stash drop              # Delete stash
```

## Undoing Changes
```bash
git restore <file>          # Discard working changes
git restore --staged <file> # Unstage a file
git reset HEAD~1            # Undo last commit (keep changes)
git reset --hard HEAD~1     # Undo last commit (discard changes)
git revert <commit>         # Create a new commit that undoes changes
```

## Viewing History
```bash
git log                     # Full log
git log --oneline           # Compact log
git log --graph             # Visual graph
git diff                    # Unstaged changes
git diff --staged           # Staged changes
git show <commit>           # Show a specific commit
```

## Tagging
```bash
git tag <name>              # Create lightweight tag
git tag -a <name> -m "msg"  # Create annotated tag
git push origin <tag>       # Push tag to remote
git push origin --tags      # Push all tags
```

## GitHub CLI (gh)
```bash
gh repo create              # Create a repo on GitHub
gh pr create                # Create a pull request
gh pr list                  # List pull requests
gh issue create             # Create an issue
gh issue list               # List issues
```
