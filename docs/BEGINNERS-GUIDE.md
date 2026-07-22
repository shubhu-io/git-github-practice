# Complete Beginner's Guide to Git & GitHub

A step-by-step guide for absolute beginners.

## What is Version Control?

**Version control** tracks changes to files over time. It lets you:
- Save different versions of your work
- Undo mistakes
- Collaborate with others
- Work on features without affecting the main code

## What is Git?

**Git** is a version control system that runs on your computer. It tracks changes in your files.

## What is GitHub?

**GitHub** is a website where you store your Git projects online. It adds collaboration features like:
- Pull requests
- Issues
- Team management

## The Git Workflow (Simple Version)

```
1. Edit files on your computer
2. Tell Git which files to track (stage)
3. Save a snapshot (commit)
4. Upload to GitHub (push)
```

## Step 1: Install Git

### Windows
1. Download from https://git-scm.com/download/win
2. Run the installer
3. Use default settings

### macOS
```bash
brew install git
```

### Linux
```bash
sudo apt-get install git
```

### Verify Installation
```bash
git --version
```

## Step 2: First-Time Setup

```bash
# Tell Git your name
git config --global user.name "Your Name"

# Tell Git your email (use your GitHub email)
git config --global user.email "your.email@example.com"

# Verify settings
git config --list
```

## Step 3: Create Your First Repository

```bash
# Create a folder
mkdir my-first-repo

# Go into the folder
cd my-first-repo

# Initialize Git
git init
```

You should see:
```
Initialized empty Git repository in /path/to/my-first-repo/.git/
```

## Step 4: Create a File

```bash
# Create a README file
echo "# My First Repository" > README.md
```

## Step 5: Stage the File

```bash
# Tell Git to track this file
git add README.md
```

Think of staging as putting items in a box before shipping.

## Step 6: Commit the File

```bash
# Save a snapshot
git commit -m "My first commit"
```

The message describes what you did.

## Step 7: Check Status

```bash
git status
```

This shows you what's changed.

## Step 8: View History

```bash
git log
```

This shows all your commits.

## Step 9: Connect to GitHub

1. Create a repository on GitHub
2. Connect your local repo:

```bash
git remote add origin https://github.com/yourusername/my-first-repo.git
```

## Step 10: Push to GitHub

```bash
git push -u origin main
```

Your code is now on GitHub!

## Daily Workflow

```
1. Pull latest changes
   git pull

2. Make changes to files

3. See what changed
   git status

4. Stage changes
   git add .

5. Commit changes
   git commit -m "Describe your changes"

6. Push to GitHub
   git push
```

## Essential Commands Cheat Sheet

| Command | What It Does |
|---------|--------------|
| `git init` | Create new repository |
| `git clone <url>` | Copy a repository |
| `git status` | See what's changed |
| `git add .` | Stage all changes |
| `git commit -m "msg"` | Save changes |
| `git push` | Upload to GitHub |
| `git pull` | Download from GitHub |
| `git log` | See history |

## Common Mistakes (And How to Fix Them)

### Committed to wrong branch
```bash
# Undo last commit (keep changes)
git reset HEAD~1

# Switch to correct branch
git checkout correct-branch

# Apply commit
git cherry-pick HEAD@{1}
```

### Wrong commit message
```bash
# Fix the last commit message
git commit --amend -m "New message"
```

### Added wrong file
```bash
# Unstage the file
git restore --staged filename
```

## Next Steps

1. Read [docs/FAQ.md](docs/FAQ.md) for more questions
2. Try [docs/EXERCISES.md](docs/EXERCISES.md) for practice
3. Run the [examples/](examples/) scripts
4. Read [docs/COMPLETE-GIT-GITHUB-GUIDE.md](docs/COMPLETE-GIT-GITHUB-GUIDE.md) for advanced topics
