# Advanced Git Commands

## git notes

Add notes to commits without changing the commit itself.

```bash
git notes add -m "note text" <commit>        # Add note to commit
git notes list                                # List all notes
git notes show <commit>                       # Show note on commit
git notes edit <commit>                       # Edit note
git notes remove <commit>                     # Remove note
git push --force origin refs/notes/*          # Push notes
```

## git replace

Replace one object with another (e.g., graft history).

```bash
git replace <object> <replacement>            # Replace object
git replace --graft <commit> <parent>         # Graft parent (reparent)
git replace --delete <object>                 # Remove replacement
git replace --list                            # List replacements
```

## git filter-branch / git filter-repo

Rewrite history (use `filter-repo` for new work).

```bash
# git filter-branch (legacy)
git filter-branch --tree-filter 'rm -f secrets.txt' HEAD
git filter-branch --env-filter 'GIT_AUTHOR_NAME="new"'

# git-filter-repo (recommended — install separately)
git filter-repo --path secrets.txt --invert-paths  # Remove file
git filter-repo --path-glob '*.log'                # Remove by glob
git filter-repo --email-callback '...'             # Replace emails
```

## git range-diff

Compare two commit ranges.

```bash
git range-diff <range1> <range2>                 # Diff two ranges
git range-diff HEAD~3..HEAD <other>~3..<other>   # Compare branches
git range-diff --creation-factor=100             # Adjust matching
```

## git interpret-trailers

Add structured trailers to commit messages.

```bash
echo "message" | git interpret-trailers --trailer "Signed-off-by: Name <email>"
echo "message" | git interpret-trailers --trailer "Reviewed-by: Name"
git interpret-trailers --in-place <file>         # Edit file in place
```

## git describe

Describe a commit relative to the nearest tag.

```bash
git describe                            # Describe HEAD
git describe --tags                     # Use lightweight tags
git describe --dirty                    # Append -dirty if modified
git describe --abbrev=0                 # Only tag name, no hash
git describe --all                      # Use any ref, not just tags
```

## git verify-commit / verify-tag

Verify GPG signatures.

```bash
git verify-commit <commit>              # Verify signed commit
git verify-tag <tag>                    # Verify signed tag
git log --show-signature               # Show commit signatures
```

## git clean

Remove untracked files.

```bash
git clean -n                            # Dry run (show files)
git clean -f                            # Remove untracked files
git clean -fd                           # Remove files + directories
git clean -fx                           # Remove ignored files too
```
