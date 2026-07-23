---
layout: single
title: "Branching & Merging"
---

# Branching & Merging

<div class="svg-diagram">
<img src="{{ '/assets/images/svg/git-branching.svg' | relative_url }}" alt="Git Branching Diagram" style="max-width:100%; height:auto; margin: 20px 0;">
</div>

## git branch

Manage branches.

```bash
git branch                              # List local branches
git branch -a                           # List all branches (local + remote)
git branch -r                           # List remote branches
git branch <name>                       # Create a branch
git branch -d <name>                    # Delete branch (merged)
git branch -D <name>                    # Force delete branch
git branch -m <old> <new>              # Rename branch
git branch -u <remote>/<branch>        # Set upstream
git branch --merged                     # List merged branches
git branch --no-merged                  # List unmerged branches
git branch -v                           # Branches with last commit
git branch --sort=-committerdate        # Sort by last commit
```

## git checkout

Switch branches or restore files (legacy — prefer `switch`/`restore`).

```bash
git checkout <branch>                   # Switch branch
git checkout -b <name>                  # Create + switch
git checkout -b <name> <base>           # Create from base
git checkout -- <file>                  # Discard local changes
git checkout <commit> -- <file>         # Restore file from commit
```

## git switch

Switch branches (modern alternative to checkout).

```bash
git switch <branch>                     # Switch to branch
git switch -c <name>                    # Create + switch
git switch -C <name>                    # Force create + switch
git switch -                            # Switch to previous branch
git switch --detach <commit>            # Detached HEAD state
git switch --guess <name>               # Guess remote branch name
```

## git restore

Restore working tree files (modern alternative to checkout).

```bash
git restore <file>                      # Discard unstaged changes
git restore --staged <file>             # Unstage (keep changes)
git restore --source <commit> <file>    # Restore from a commit
git restore --worktree --staged .       # Full reset to HEAD
```

## git merge

Integrate changes from another branch.

```bash
git merge <branch>                      # Merge branch into current
git merge --no-ff <branch>              # Keep branch history (merge commit)
git merge --ff-only <branch>            # Only fast-forward
git merge --squash <branch>             # Squash all into one commit
git merge --abort                       # Abort conflicted merge
git merge --continue                    # Continue after resolving conflicts
git merge --no-edit <branch>            # Use auto message
```

### Merge Strategies

```bash
git merge -s recursive -X patience     # Recursive with patience
git merge -s ours <branch>             # Keep our version entirely
git merge -s subtree <branch>          # Subtree merge
```

## git rebase

Reapply commits on top of another base.

```bash
git rebase <branch>                     # Rebase current onto branch
git rebase -i HEAD~5                    # Interactive: squash, reword, reorder
git rebase --onto <base> <upstream>     # Transplant commits
git rebase --abort                      # Abort rebase
git rebase --continue                   # Continue after conflicts
git rebase --skip                       # Skip current commit
git rebase --update-refs               # Update dependent branches
```

## git mergetool

Resolve merge conflicts using a visual tool.

```bash
git mergetool                           # Launch configured merge tool
git mergetool --tool=vscode             # Use specific tool
```
