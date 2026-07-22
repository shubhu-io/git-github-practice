# Stashing

## git stash

Temporarily save uncommitted changes.

```bash
git stash                               # Stash tracked changes
git stash push -m "message"             # Stash with message
git stash --include-untracked           # Stash untracked files too
git stash -u                            # Short form of --include-untracked
git stash --all                         # Stash everything (incl. ignored)
git stash --patch                       # Stash interactively
git stash --keep-index                  # Stash but keep staged
```

## Apply stashes

```bash
git stash list                          # List all stashes
git stash show                          # Show changes in latest stash
git stash show -p                       # Show diff of latest stash
git stash show stash@{1}                # Show specific stash
git stash pop                           # Apply + drop latest stash
git stash apply                         # Apply without dropping
git stash apply stash@{1}               # Apply specific stash
git stash pop stash@{1}                 # Pop specific stash
git stash drop                          # Drop latest stash
git stash drop stash@{1}                # Drop specific stash
git stash clear                         # Remove all stashes
git stash branch <name>                 # Create branch from stash
```

## Use Cases

```bash
# Switch branches mid-work without committing
git stash -m "WIP: half-finished feature"
git switch other-branch
# ... work ...
git switch original-branch
git stash pop

# Stash only specific files
git stash -p                            # Select hunks to stash

# Apply stash to different branch
git stash branch new-feature stash@{0}
```
