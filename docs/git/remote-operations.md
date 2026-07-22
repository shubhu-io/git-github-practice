# Remote Operations

## git remote

Manage remote repositories.

```bash
git remote -v                           # List remotes (with URLs)
git remote add <name> <url>             # Add a remote
git remote remove <name>                # Remove a remote
git remote rename <old> <new>           # Rename a remote
git remote set-url <name> <url>         # Change remote URL
git remote get-url <name>               # Show remote URL
git remote show <name>                  # Show remote details
git remote prune <name>                 # Prune stale tracking branches
git remote update                       # Fetch all remotes
```

## git fetch

Download objects and refs from remote.

```bash
git fetch                               # Fetch from origin
git fetch <remote>                      # Fetch from specific remote
git fetch --all                         # Fetch from all remotes
git fetch --prune                       # Fetch + remove stale refs
git fetch --depth 1                     # Shallow fetch
git fetch origin <branch>               # Fetch specific branch
git fetch --tags                        # Fetch all tags
```

## git push

Upload objects and refs to remote.

```bash
git push                                # Push to default remote
git push <remote> <branch>              # Push a branch
git push -u <remote> <branch>           # Push + set upstream
git push --all                          # Push all branches
git push --tags                         # Push all tags
git push --delete <remote> <branch>     # Delete remote branch
git push --force                        # Force push (dangerous)
git push --force-with-lease             # Safer force (checks remote)
git push --mirror <url>                 # Mirror all refs
git push -n                             # Dry run
git push <remote> :<branch>             # Delete remote branch (alt syntax)
```

## git pull

Fetch and integrate (fetch + merge).

```bash
git pull                                # Pull from upstream
git pull --rebase                       # Pull with rebase instead of merge
git pull --ff-only                      # Only fast-forward
git pull --autostash                    # Auto stash/stash pop
git pull <remote> <branch>              # Pull specific branch
```

## git ls-remote

List references in a remote repository.

```bash
git ls-remote                           # List all refs
git ls-remote <url>                     # List refs from URL
git ls-remote --heads <remote>          # List branches only
git ls-remote --tags <remote>           # List tags only
git ls-remote --refs <remote>           # List non-peeled refs
```
