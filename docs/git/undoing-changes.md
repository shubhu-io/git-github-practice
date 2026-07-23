---
layout: single
title: "Undoing Changes"
---

# Undoing Changes

## git reset

Reset current HEAD to a specific state.

```bash
git reset --soft HEAD~1                 # Undo commit, keep changes staged
git reset --mixed HEAD~1                # Undo commit, unstage changes (default)
git reset --hard HEAD~1                 # Discard commit + changes entirely
git reset --hard <commit>               # Reset to specific commit
git reset HEAD <file>                   # Unstage a file
git reset --soft <commit>               # Reset to commit, keep all changes
git reset --keep <commit>               # Reset but keep working tree
```

| Mode | HEAD | Staging | Working Tree |
|---|---|---|---|
| `--soft` | ✓ | Preserved | Preserved |
| `--mixed` (default) | ✓ | ✓ Reset | Preserved |
| `--hard` | ✓ | ✓ Reset | ✓ Reset |
| `--keep` | ✓ | ✓ Reset | Preserved (abort if conflict) |

## git revert

Create a new commit that undoes a previous commit (safe for shared history).

```bash
git revert <commit>                     # Revert a commit
git revert HEAD                         # Revert last commit
git revert HEAD~3..HEAD                 # Revert range of commits
git revert --no-commit <commit>         # Revert without committing
git revert --continue                   # Continue after conflicts
git revert --abort                      # Abort revert
git revert -n <commit>                  # Revert multiple, commit once
```

## git cherry-pick

Apply specific commits from another branch.

```bash
git cherry-pick <commit>                # Apply a commit
git cherry-pick <commit1> <commit2>     # Apply multiple commits
git cherry-pick A..B                    # Apply range (exclusive of A)
git cherry-pick A^..B                   # Apply range (inclusive of A)
git cherry-pick --no-commit <commit>    # Apply without committing
git cherry-pick --continue              # Continue after conflicts
git cherry-pick --abort                 # Abort cherry-pick
git cherry-pick --signoff <commit>      # Add Signed-off-by
```

## git reflog

Reference log — records where HEAD has pointed.

```bash
git reflog                              # Show HEAD reflog
git reflog show <branch>                # Show branch reflog
git reflog --all                        # Show all refs
git reflog --date=iso                   # With ISO dates
git reflog expire --expire=30.days      # Expire old entries
git reflog delete HEAD@{2}              # Delete a reflog entry

# Recover "lost" commits
git reflog                              # Find the commit hash
git reset --hard <hash>                 # Reset to it
git checkout -b recover <hash>          # Or create branch at it
```

## git bisect

Binary search to find the commit that introduced a bug.

```bash
git bisect start                        # Start bisect
git bisect bad                          # Mark current as bad
git bisect good <commit>                # Mark known-good commit
# Git checks out middle commit — test it
git bisect good                         # If this commit is good
git bisect bad                          # If this commit is bad
git bisect reset                        # End bisect
git bisect run <script>                 # Automated bisect
```
