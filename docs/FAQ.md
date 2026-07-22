# Frequently Asked Questions

Common Git and GitHub questions and answers.

## General Questions

### What is Git?

Git is a distributed version control system that tracks changes in source code during software development. It was created by Linus Torvalds in 2005.

### What is GitHub?

GitHub is a web-based platform for version control and collaboration. It provides hosting for Git repositories with additional features like issue tracking, pull requests, and project management.

### What is the difference between Git and GitHub?

- **Git**: Version control system (runs locally)
- **GitHub**: Cloud platform for hosting Git repos (runs online)

### Why use version control?

- Track changes over time
- Collaborate with others
- Revert to previous versions
- Branch and experiment safely
- Maintain code history

## Getting Started

### How do I install Git?

```bash
# Windows
# Download from https://git-scm.com/download/win

# macOS
brew install git

# Linux
sudo apt-get install git
```

### How do I set up Git?

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

### How do I create a repository?

```bash
# New repository
mkdir my-project
cd my-project
git init

# Clone existing repository
git clone https://github.com/user/repo.git
```

## Basic Commands

### What is the Git workflow?

```
Working Directory → Staging Area → Repository
     (edit)         (git add)    (git commit)
```

### How do I save changes?

```bash
git add .              # Stage changes
git commit -m "message"  # Commit changes
```

### How do I see what changed?

```bash
git status            # See modified files
git diff              # See detailed changes
git log               # See commit history
```

## Branching

### What is a branch?

A branch is a lightweight movable pointer to a commit. It allows you to develop features in isolation.

### How do I create a branch?

```bash
git branch feature-name        # Create branch
git checkout feature-name      # Switch to branch
git checkout -b feature-name   # Create and switch
```

### How do I merge branches?

```bash
git checkout main              # Switch to main
git merge feature-name         # Merge feature
```

### What is a merge conflict?

A merge conflict occurs when Git cannot automatically merge changes from different branches. You must manually resolve the conflicts.

## Remote Repositories

### What is a remote?

A remote is a version of your repository hosted elsewhere (e.g., GitHub).

### How do I connect to a remote?

```bash
git remote add origin https://github.com/user/repo.git
```

### How do I push changes?

```bash
git push origin main           # Push main branch
git push -u origin main        # Push and set upstream
```

### How do I get changes?

```bash
git pull                       # Fetch and merge
git fetch                      # Download only
```

## Undoing Changes

### How do I undo unstaged changes?

```bash
git restore file.txt           # Discard changes
```

### How do I unstage a file?

```bash
git restore --staged file.txt  # Unstage
```

### How do I undo a commit?

```bash
git reset HEAD~1               # Keep changes
git reset --hard HEAD~1        # Discard changes
git revert HEAD                # Create undo commit
```

### How do I fix my last commit message?

```bash
git commit --amend -m "new message"
```

## Stashing

### What is stashing?

Stashing temporarily stores changes so you can work on something else.

### How do I stash changes?

```bash
git stash                      # Stash changes
git stash list                 # List stashes
git stash pop                  # Apply and remove
git stash apply                # Apply only
```

## Tags

### What is a tag?

A tag is a named pointer to a commit, typically used for releases.

### How do I create a tag?

```bash
git tag v1.0.0                 # Lightweight tag
git tag -a v1.0.0 -m "Release"  # Annotated tag
git push origin v1.0.0         # Push tag
```

## GitHub Specific

### How do I create a Pull Request?

1. Fork the repository
2. Create a branch
3. Make changes and commit
4. Push to your fork
5. Create PR on GitHub

### How do I resolve merge conflicts?

1. Fetch latest changes
2. Rebase on main
3. Resolve conflicts in files
4. Continue rebase
5. Force push

### What are GitHub Actions?

GitHub Actions is a CI/CD platform that automates workflows. It runs jobs when events occur (push, PR, etc.).

## Troubleshooting

### "Permission denied (publickey)"

```bash
# Add SSH key
ssh-add ~/.ssh/id_rsa

# Test connection
ssh -T git@github.com
```

### "Repository not found"

- Check the repository URL
- Ensure you have access
- Verify the repository exists

### "Merge conflict"

1. Open conflicted file
2. Find conflict markers
3. Choose which changes to keep
4. Remove markers
5. Stage and commit

### "Detached HEAD"

```bash
git checkout main              # Return to branch
```

## Advanced

### What is rebasing?

Rebasing moves a sequence of commits to a new base commit, creating a linear history.

### What is cherry-picking?

Cherry-picking applies a specific commit from one branch to another.

### What is interactive rebase?

Interactive rebase lets you modify commits (squash, reword, edit, drop) during rebase.

### What is git bisect?

Git bisect uses binary search to find the commit that introduced a bug.

## Getting Help

```bash
git help <command>             # View help
git <command> --help           # Quick help
```

## Resources

- [Git Documentation](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)
- [Learn Git Branching](https://learngitbranching.js.org/)
- [Git Immersion](https://gitimmersion.com/)
