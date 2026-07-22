---
layout: default
title: Git Tips & Tricks
nav_order: 24
---
# Git Tips & Tricks

Pro tips to work faster and smarter.

## Shortcuts & Aliases

### Essential Aliases
```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm commit
git config --global alias.lg "log --oneline --graph --all"
git config --global alias.last "log -1 HEAD --stat"
git config --global alias.unstage "reset HEAD --"
```

### Use Aliases
```bash
git st      # Instead of git status
git co main # Instead of git checkout main
git lg      # Pretty log
git last    # Last commit details
```

## Useful Commands

### See What Changed Without Staging
```bash
git diff
```

### See What's Staged
```bash
git diff --staged
```

### See All Changes Since Last Commit
```bash
git diff HEAD
```

### See Changes in One File
```bash
git diff -- path/to/file.txt
```

### See Who Changed What Line
```bash
git blame file.txt
```

### See History of Changes
```bash
git log -p file.txt
```

### Find a Commit That Changed Something
```bash
git log -S "function_name" --oneline
```

## Stashing Tricks

### Stash with a Name
```bash
git stash save "Working on login page"
```

### See Stash Contents
```bash
git stash show -p
```

### Apply Specific Stash
```bash
git stash apply stash@{2}
```

### Create Branch from Stash
```bash
git stash branch new-branch
```

## Branch Tricks

### See All Branches (Local and Remote)
```bash
git branch -a
```

### See Branches You're Ahead Of
```bash
git branch -a --merged origin/main
```

### Delete Merged Branches
```bash
git branch --merged | grep -v "\*\|main\|master" | xargs -n 1 git branch -d
```

### Rename Branch
```bash
git branch -m old-name new-name
```

## Commit Tricks

### Commit Without Staging
```bash
git commit -am "message"
```

### Amend Last Commit Message
```bash
git commit --amend -m "New message"
```

### Add Forgotten File to Last Commit
```bash
git add forgotten-file.txt
git commit --amend --no-edit
```

### Empty Commit (No Changes)
```bash
git commit --allow-empty -m "Trigger CI"
```

## Log Tricks

### Pretty One-Line Log
```bash
git log --oneline
```

### Visual Branch Graph
```bash
git log --oneline --graph --all
```

### Show Last 5 Commits
```bash
git log -5
```

### Show Commits by Author
```bash
git log --author="John"
```

### Show Commits in Date Range
```bash
git log --after="2024-01-01" --before="2024-12-31"
```

### Show Commits with File Stats
```bash
git log --stat
```

## Remote Tricks

### See Remote URLs
```bash
git remote -v
```

### Fetch All Remotes
```bash
git fetch --all --prune
```

### See Remote Branches
```bash
git branch -r
```

### Delete Remote Branch
```bash
git push origin --delete branch-name
```

### Set Upstream Branch
```bash
git push -u origin branch-name
```

## Undo Tricks

### Undo Last Commit (Keep Changes)
```bash
git reset HEAD~1
```

### Undo Last Commit (Discard Changes) - DANGEROUS
```bash
git reset --hard HEAD~1
```

### Undo a File to Last Commit
```bash
git restore filename.txt
```

### See Where HEAD Was Before
```bash
git reflog
```

### Recover Lost Commit
```bash
git reflog
git cherry-pick abc1234
```

## Search Tricks

### Find String in Code
```bash
git grep "search term"
```

### Find String in History
```bash
git log -S "search term"
```

### Find String with Regex
```bash
git log -G "regex pattern"
```

## Clean Tricks

### Preview What Would Be Deleted
```bash
git clean -n
```

### Delete Untracked Files
```bash
git clean -f
```

### Delete Untracked Files and Directories
```bash
git clean -fd
```

### Delete Ignored Files
```bash
git clean -Xf
```

## Advanced Tricks

### Cherry-Pick Without Committing
```bash
git cherry-pick --no-commit abc1234
```

### Create Empty Branch
```bash
git checkout --orphan empty-branch
git rm -rf .
git commit --allow-empty -m "Initial empty commit"
```

### See File at Specific Commit
```bash
git show abc1234:file.txt
```

### See Diff Between Tags
```bash
git diff v1.0.0 v2.0.0
```

### Interactive Add (Stage Hunks)
```bash
git add -p
```

### Abort Merge
```bash
git merge --abort
```

### Abort Rebase
```bash
git rebase --abort
```

## Git Config Tips

### Use VS Code as Editor
```bash
git config --global core.editor "code --wait"
```

### Use VS Code as Diff Tool
```bash
git config --global diff.tool vscode
git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'
```

### Auto-Correct Typos
```bash
git config --global help.autocorrect 1
```

### Colorful Output
```bash
git config --global color.ui auto
```

## Productivity Tips

1. **Use `git status` often** - Know what's happening
2. **Commit often** - Small commits are easier to manage
3. **Write good messages** - Future you will thank you
4. **Use branches** - Keep main clean
5. **Pull before push** - Avoid conflicts
6. **Use stash** - Quick context switching
7. **Learn rebase** - Clean history
8. **Use aliases** - Speed up commands

## Resources

- [Git Documentation](https://git-scm.com/doc)
- [GitHub Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [Oh Shit, Git!?!](https://ohshitgit.com/)
- [Learn Git Branching](https://learngitbranching.js.org/)
