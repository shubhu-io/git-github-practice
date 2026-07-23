---
layout: single
title: Commands by Task
---
# Git Commands by Task

Find the right command for what you want to do.

## Starting a Project

| Task | Command |
|------|---------|
| Initialize a new repo | `git init` |
| Clone an existing repo | `git clone <url>` |
| Clone to a specific folder | `git clone <url> <folder>` |
| Clone a specific branch | `git clone -b <branch> <url>` |

## Saving Changes

| Task | Command |
|------|---------|
| See what's changed | `git status` |
| See detailed changes | `git diff` |
| Stage a file | `git add <file>` |
| Stage all changes | `git add .` |
| Stage parts of a file | `git add -p` |
| Commit staged changes | `git commit -m "message"` |
| Commit all tracked files | `git commit -am "message"` |
| Amend last commit | `git commit --amend` |

## Viewing History

| Task | Command |
|------|---------|
| See all commits | `git log` |
| See compact log | `git log --oneline` |
| See visual graph | `git log --oneline --graph` |
| See last N commits | `git log -N` |
| See specific file history | `git log -p <file>` |
| See who changed a line | `git blame <file>` |
| See changes between commits | `git diff <commit1>..<commit2>` |

## Branching

| Task | Command |
|------|---------|
| List branches | `git branch` |
| List all branches | `git branch -a` |
| Create a branch | `git branch <name>` |
| Switch to a branch | `git checkout <branch>` |
| Create and switch | `git checkout -b <branch>` |
| Rename a branch | `git branch -m <old> <new>` |
| Delete a branch | `git branch -d <branch>` |
| Force delete | `git branch -D <branch>` |

## Merging

| Task | Command |
|------|---------|
| Merge a branch | `git merge <branch>` |
| Abort a merge | `git merge --abort` |
| Squash merge | `git merge --squash <branch>` |

## Remote Operations

| Task | Command |
|------|---------|
| See remotes | `git remote -v` |
| Add a remote | `git remote add <name> <url>` |
| Fetch from remote | `git fetch` |
| Pull from remote | `git pull` |
| Push to remote | `git push` |
| Push and set upstream | `git push -u origin <branch>` |
| Force push (safe) | `git push --force-with-lease` |
| Delete remote branch | `git push origin --delete <branch>` |

## Stashing

| Task | Command |
|------|---------|
| Stash changes | `git stash` |
| Stash with message | `git stash save "message"` |
| List stashes | `git stash list` |
| Apply stash | `git stash apply` |
| Pop stash | `git stash pop` |
| Drop stash | `git stash drop` |
| Clear all stashes | `git stash clear` |

## Undoing Changes

| Task | Command |
|------|---------|
| Discard file changes | `git restore <file>` |
| Discard all changes | `git restore .` |
| Unstage a file | `git restore --staged <file>` |
| Undo last commit (keep) | `git reset HEAD~1` |
| Undo last commit (lose) | `git reset --hard HEAD~1` |
| Undo a pushed commit | `git revert <commit>` |
| See where HEAD was | `git reflog` |
| Recover lost commit | `git reflog` then `git checkout <hash>` |

## Tagging

| Task | Command |
|------|---------|
| List tags | `git tag` |
| Create lightweight tag | `git tag <name>` |
| Create annotated tag | `git tag -a <name> -m "message"` |
| Push a tag | `git push origin <tag>` |
| Push all tags | `git push origin --tags` |
| Delete a tag | `git tag -d <name>` |

## Searching

| Task | Command |
|------|---------|
| Search in code | `git grep "search"` |
| Search in history | `git log -S "search"` |
| Find a commit | `git log --grep="search"` |

## Cleaning

| Task | Command |
|------|---------|
| Preview cleanup | `git clean -n` |
| Delete untracked files | `git clean -f` |
| Delete untracked files+dirs | `git clean -fd` |
| Delete ignored files | `git clean -Xf` |

## Advanced

| Task | Command |
|------|---------|
| Interactive rebase | `git rebase -i HEAD~N` |
| Cherry-pick a commit | `git cherry-pick <commit>` |
| Bisect (find bug) | `git bisect start` |
| See repository stats | `git shortlog -sn` |
| Find large files | `git rev-list --objects --all \| git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \| sort -rnk2 \| head -20` |

## Quick Reference

```
START:    git init / git clone <url>
SAVE:     git add . && git commit -m "msg"
SEND:     git push
GET:      git pull
LOOK:     git log --oneline
BACK:     git reset HEAD~1
FIX:      git restore <file>
BRANCH:   git checkout -b <name>
MERGE:    git merge <branch>
STASH:    git stash / git stash pop
```

## Resources

- [Git Documentation](https://git-scm.com/docs)
- [GitHub Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [Git Quick Reference](QUICK-REFERENCE.md)
