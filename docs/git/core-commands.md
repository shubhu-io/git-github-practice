# Core Git Commands

## git init

Create a new Git repository.

```bash
git init                                # Initialize in current dir
git init <directory>                    # Initialize in specific dir
git init --bare <directory>             # Bare repo (for servers)
git init --initial-branch=main <dir>    # Set default branch name
```

## git clone

Copy an existing repository.

```bash
git clone <url>                         # Clone to default dir name
git clone <url> <directory>             # Clone to specific dir
git clone --depth 1 <url>               # Shallow clone (last commit only)
git clone --branch <branch> <url>       # Clone specific branch
git clone --recursive <url>             # Clone with submodules
git clone --single-branch <url>         # Only fetch one branch
git clone --mirror <url>                # Bare mirror (full copy)
```

## git add

Stage changes for commit.

```bash
git add <file>                          # Stage a file
git add .                               # Stage all changes
git add -p                              # Stage interactively (hunk by hunk)
git add -A                              # Stage all (new, modified, deleted)
git add -u                              # Stage tracked files only
git add --intent-to-add <file>          # Track file without staging content
git add -n .                            # Dry run (show what would be staged)
```

## git commit

Record staged changes.

```bash
git commit -m "message"                 # Commit with inline message
git commit                              # Open editor for message
git commit -a -m "message"              # Stage tracked files + commit
git commit --amend                      # Amend last commit (edit message)
git commit --amend --no-edit            # Amend without changing message
git commit --allow-empty                # Create empty commit
git commit --signoff                    # Add Signed-off-by trailer
```

### Conventional Commit Format

```
<type>(<scope>): <description>

<body>

<footer>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`

## git status

Show working tree state.

```bash
git status                              # Full status
git status -s                           # Short format
git status -b                           # Branch info + short status
git status --ignored                    # Show ignored files
```

## git log

View commit history.

```bash
git log                                 # Full log
git log --oneline                       # Compact one-line format
git log --graph                         # ASCII graph of branches
git log --oneline --graph --all         # Full branching view
git log -n 5                            # Last 5 commits
git log --author="name"                 # Filter by author
git log --since="2 weeks ago"           # Filter by date
git log --grep="fix"                    # Filter by message
git log -- <file>                       # History of a file
git log -p <file>                       # History with diffs
git log --stat                          # With file change stats
git log --format="%h %s"               # Custom format
git log --oneline --graph --decorate    # With branch/tag labels
git reflog                              # Local reference log
```

## git diff

Show changes between commits, branches, or working tree.

```bash
git diff                                # Unstaged changes
git diff --staged                       # Staged changes (ready to commit)
git diff HEAD                           # All changes vs last commit
git diff <branch1> <branch2>            # Between branches
git diff <commit1> <commit2>            # Between commits
git diff --stat                         # Summary of changes
git diff --word-diff                    # Word-level diff
git diff --check                        # Check for whitespace errors
git diff --name-only                    # List changed files only
git diff <commit> -- <file>             # File changes in a commit
```
