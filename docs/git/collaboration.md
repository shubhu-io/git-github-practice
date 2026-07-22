# Collaboration

## git tag

Mark specific commits (releases, versions).

```bash
git tag                                 # List tags
git tag -l "v2.*"                       # Search tags by pattern
git tag <name>                          # Create lightweight tag
git tag -a <name> -m "message"          # Create annotated tag
git tag -a <name> <commit> -m "msg"     # Tag a past commit
git tag -d <name>                       # Delete local tag
git push origin <name>                  # Push a tag
git push origin --tags                  # Push all tags
git push --delete origin <name>         # Delete remote tag
git checkout <tag>                      # Checkout tag (detached HEAD)
git describe                            # Describe current commit relative to tag
```

## git submodule

Embed one repo inside another.

```bash
git submodule add <url> <path>          # Add a submodule
git submodule init                      # Initialize submodule config
git submodule update                    # Fetch + checkout submodules
git submodule update --init --recursive # Full init for nested submodules
git submodule foreach <cmd>             # Run command in each submodule
git submodule status                    # Show submodule status
git submodule sync                      # Update remote URL config
git submodule deinit <path>             # Unregister a submodule
```

## git worktree

Work on multiple branches simultaneously.

```bash
git worktree add <path> <branch>        # Checkout branch in new dir
git worktree list                       # List all worktrees
git worktree remove <path>              # Remove a worktree
git worktree prune                      # Clean up stale worktree refs
git worktree add -b <branch> <path>     # Create branch + worktree
```

## git blame

Show who last modified each line.

```bash
git blame <file>                        # Annotate file with author/commit
git blame -L 10,20 <file>               # Only lines 10-20
git blame -w <file>                     # Ignore whitespace changes
git blame -e <file>                     # Show author email
git blame --since="3 months ago" <file> # Since a date
git blame <commit> -- <file>            # Blame at specific commit
```

## git grep

Search content in tracked files.

```bash
git grep "pattern"                      # Search working tree
git grep "pattern" <commit>             # Search in a commit
git grep -i "pattern"                   # Case-insensitive
git grep -n "pattern"                   # Show line numbers
git grep -c "pattern"                   # Count matches per file
git grep -l "pattern"                   # List matching files only
git grep -w "word"                      # Whole word match
git grep --cached "pattern"             # Search staged files
```

## git archive

Create an archive of the repository.

```bash
git archive -o repo.tar HEAD            # Archive current HEAD
git archive --format=zip HEAD > repo.zip
git archive --prefix=project/ HEAD      # Archive with prefix dir
git archive -o latest.tar <tag>         # Archive a tag
```
