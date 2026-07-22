---
title: Learning Path
layout: single
sidebar:
  nav: "docs"
---

# Learning Path for Git & GitHub

A complete 4-week structured guide to mastering Git and GitHub — from your first commit to advanced automation.

---

## Learning Path Overview

```
Week 1: Git Basics
  Day 1-2: Installation & Setup
  Day 3-4: Basic Commands (add, commit, status, log)
  Day 5-7: First Repository & Push to GitHub

Week 2: Branching & Merging
  Day 1-2: Creating & Switching Branches
  Day 3-4: Merging Branches
  Day 5-7: Merge Conflicts & Resolution

Week 3: Collaboration
  Day 1-2: Remote Repositories
  Day 3-4: Pull Requests
  Day 5-7: Fork Workflow

Week 4: Advanced Topics
  Day 1-2: Stashing & Rebase
  Day 3-4: Cherry-pick & Tags
  Day 5-7: GitHub Actions & Automation
```

---

## Week 1: Git Basics

### Day 1-2: Installation & Setup

**Learning Objectives:**
- Understand what version control is and why Git dominates the industry
- Install Git on your operating system
- Configure your Git identity and preferences

**What is Git?**
Git is a distributed version control system that tracks changes in files. It allows multiple developers to work on the same project simultaneously without overwriting each others work.

**Installation:**

| OS | Instructions |
|----|-------------|
| Windows | Download from [git-scm.com](https://git-scm.com) or run `winget install Git.Git` |
| macOS | Run `brew install git` or download from [git-scm.com](https://git-scm.com) |
| Linux | Run `sudo apt install git` (Ubuntu/Debian) or `sudo dnf install git` (Fedora) |

**Configure Git:**
```bash
# Set your identity (required for commits)
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

# Set default branch name
git config --global init.defaultBranch main

# Useful aliases
git config --global alias.st "status -sb"
git config --global alias.co "checkout"
git config --global alias.br "branch"
git config --global alias.cm "commit -m"
git config --global alias.lg "log --oneline --graph --all"

# Verify configuration
git config --list
```

**Check Your Understanding:**
- [ ] I know what Git is and why developers use it
- [ ] Git is installed on my system
- [ ] My name and email are configured
- [ ] I have set up at least one alias

---

### Day 3-4: Basic Commands

**Learning Objectives:**
- Initialize a repository
- Stage and commit changes
- Check repository status
- View commit history

**Essential Commands:**

| Command | What It Does |
|---------|-------------|
| `git init` | Create a new Git repository |
| `git status` | Show the state of the working directory |
| `git add <file>` | Stage a file for commit |
| `git add .` | Stage all changed files |
| `git commit -m "message"` | Commit staged changes with a message |
| `git log` | Show commit history |
| `git log --oneline` | Compact commit history |
| `git diff` | Show unstaged changes |
| `git diff --staged` | Show staged changes |

**Practice:**
```bash
# Create a project
mkdir my-first-repo
cd my-first-repo
git init

# Create and commit a file
echo "# My Project" > README.md
git status                  # See README.md as untracked
git add README.md
git status                  # See README.md as staged
git commit -m "feat: initial commit with README"

# View your work
git log --oneline
git log --oneline --graph --all
```

**Commit Message Convention:**
Follow the conventional commits format:
```
<type>: <description>

Types: feat (feature), fix (bug fix), docs (documentation),
       style (formatting), refactor (code restructuring),
       test (adding tests), chore (maintenance)
```

**Check Your Understanding:**
- [ ] I can create a repository with `git init`
- [ ] I can stage files with `git add`
- [ ] I can commit with a descriptive message
- [ ] I can view my commit history
- [ ] I understand the difference between staged and unstaged changes

---

### Day 5-7: First Repository & Push to GitHub

**Learning Objectives:**
- Create a GitHub account
- Create a remote repository on GitHub
- Connect your local repo to GitHub
- Push commits to the remote

**Setup GitHub:**
1. Go to [github.com](https://github.com) and create an account
2. Verify your email address
3. Create a [Personal Access Token](https://github.com/settings/tokens) for CLI access

**Create a Repository on GitHub:**
```bash
# Using GitHub CLI (recommended)
gh auth login
gh repo create my-first-repo --public --description "My first GitHub project"

# Or create manually at github.com/new
```

**Connect and Push:**
```bash
# Add the remote
git remote add origin https://github.com/YOUR-USERNAME/my-first-repo.git

# Push your code
git push -u origin main

# The -u flag sets upstream tracking (only needed once)
# After that, just use: git push
```

**Verify:**
- Visit `https://github.com/YOUR-USERNAME/my-first-repo`
- Your files and commit should be visible on GitHub
- You can view your repository online

**Key Remote Commands:**
```bash
git remote -v              # List remotes
git push                   # Push commits to remote
git pull                   # Pull latest from remote
git fetch                  # Download objects from remote
git clone <url>            # Clone a remote repo locally
```

**Check Your Understanding:**
- [ ] I have a GitHub account
- [ ] I can create a repository on GitHub
- [ ] I can push local commits to GitHub
- [ ] I can pull changes from a remote repository
- [ ] I understand the difference between `git pull` and `git fetch`

---

## Week 2: Branching & Merging

### Day 1-2: Creating & Switching Branches

**Learning Objectives:**
- Understand what branches are and why they matter
- Create, switch, and delete branches
- View all branches in your repository

**What are Branches?**
A branch is a movable pointer to a commit. Branches let you develop features, fix bugs, or experiment in isolated environments without affecting the main codebase.

```bash
# List branches
git branch                 # Local branches
git branch -r              # Remote branches
git branch -a              # All branches

# Create a branch
git branch feature/login

# Switch to a branch
git checkout feature/login

# Create and switch in one command
git checkout -b feature/login

# Delete a branch
git branch -d feature/login      # Safe delete (checks for unmerged work)
git branch -D feature/login      # Force delete

# Rename a branch
git branch -m old-name new-name
```

**Practice Workflow:**
```bash
# Start on main
git checkout main

# Create a feature branch
git checkout -b feature/awesome

# Make changes
echo "Awesome feature" > awesome.txt
git add awesome.txt
git commit -m "feat: add awesome feature"

# Switch back to main
git checkout main
# Note: awesome.txt is NOT here — it only exists on the feature branch
```

**Branch Naming Conventions:**
```
feature/<name>      — New features
fix/<name>          — Bug fixes
hotfix/<name>       — Urgent production fixes
chore/<name>        — Maintenance tasks
docs/<name>         — Documentation updates
```

**Check Your Understanding:**
- [ ] I can list all branches in a repository
- [ ] I can create and switch between branches
- [ ] I can delete branches safely
- [ ] I understand that branches are isolated environments
- [ ] I know the difference between `git branch` and `git checkout -b`

---

### Day 3-4: Merging Branches

**Learning Objectives:**
- Merge one branch into another
- Understand fast-forward vs three-way merges
- Handle merge commits

**Merging Basics:**
```bash
# Switch to the branch you want to merge INTO
git checkout main

# Merge the feature branch INTO main
git merge feature/login

# View the merge result
git log --oneline --graph --all
```

**Types of Merges:**

| Type | When It Happens | Result |
|------|----------------|--------|
| Fast-forward | Target branch has no new commits | Linear history, no merge commit |
| Three-way merge | Both branches have diverged | Creates a merge commit |

```bash
# Force a merge commit even with fast-forward
git merge --no-ff feature/login

# Abort a merge with conflicts
git merge --abort
```

**Practice:**
```bash
# Setup
git checkout -b feature/header
echo "# Header" > header.txt
git add header.txt && git commit -m "feat: add header"

git checkout main
echo "Main update" >> README.md
git add README.md && git commit -m "docs: update README"

# Merge (creates a merge commit since both branches diverged)
git merge feature/header
git log --oneline --graph --all
```

**Check Your Understanding:**
- [ ] I can merge a branch into another
- [ ] I understand fast-forward vs three-way merges
- [ ] I can view the merge history as a graph
- [ ] I know how to abort a merge if needed

---

### Day 5-7: Merge Conflicts

**Learning Objectives:**
- Understand what causes merge conflicts
- Resolve conflicts manually
- Use merge tools

**What Causes Conflicts?**
Conflicts occur when two branches modify the same line of the same file differently. Git cannot automatically decide which change to keep.

**Creating a Conflict:**
```bash
# On main
echo "Main content" > conflict.txt
git add conflict.txt && git commit -m "feat: add conflict file on main"

# Create and switch to feature branch
git checkout -b feature/change
echo "Feature content" > conflict.txt
git add conflict.txt && git commit -m "feat: change conflict file on feature"

# Switch back to main and try to merge
git checkout main
git merge feature/change
# CONFLICT! Git will show an error
```

**Resolving a Conflict:**
When a conflict occurs, Git marks the file:
```
<<<<<<< HEAD
Main content
=======
Feature content
>>>>>>> feature/change
```

1. Open the conflicted file in your editor
2. Decide which content to keep, or combine both
3. Remove the conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
4. Stage the resolved file: `git add conflict.txt`
5. Complete the merge: `git commit`

**Merge Tools:**
```bash
# Use VS Code as merge tool
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait $MERGED'

# Launch merge tool
git mergetool
```

**Best Practices:**
- Pull and merge frequently to minimize conflicts
- Communicate with your team about who is working on what
- Keep changes small and focused
- Use meaningful branch names

**Check Your Understanding:**
- [ ] I can identify a merge conflict
- [ ] I can read conflict markers and understand both sides
- [ ] I can resolve a conflict manually
- [ ] I can complete the merge after resolving

---

## Week 3: Collaboration

### Day 1-2: Remote Repositories

**Learning Objectives:**
- Understand remote repositories
- Clone, push, and pull from remotes
- Work with multiple remotes

**What is a Remote?**
A remote is a version of your repository hosted on a server (like GitHub). Remotes enable collaboration between multiple developers.

```bash
# Add a remote
git remote add origin https://github.com/user/repo.git

# View remotes
git remote -v

# Remove a remote
git remote remove origin

# Rename a remote
git remote rename origin upstream
```

**Syncing with Remote:**
```bash
# Push local commits to remote
git push origin main

# Pull remote changes (fetch + merge)
git pull origin main

# Fetch without merging
git fetch origin

# View remote branches
git branch -r

# Check difference between local and remote
git log HEAD..origin/main --oneline   # Commits you don't have locally
git log origin/main..HEAD --oneline   # Commits not on remote
```

**Clone a Repository:**
```bash
git clone https://github.com/user/repo.git
cd repo
```

**Practice:**
```bash
# Clone this repository
git clone https://github.com/shubhu-io/git-github-practice.git
cd git-github-practice

# Check remotes
git remote -v

# Make a change and push
echo "My practice note" >> practice.txt
git add practice.txt
git commit -m "feat: add practice note"
git push origin main
```

**Check Your Understanding:**
- [ ] I can add and view remote repositories
- [ ] I can push commits to a remote
- [ ] I can pull changes from a remote
- [ ] I understand `git fetch` vs `git pull`

---

### Day 3-4: Pull Requests

**Learning Objectives:**
- Create a pull request on GitHub
- Review and discuss code changes
- Merge a pull request

**What is a Pull Request?**
A pull request (PR) is a proposal to merge changes from one branch into another. PRs enable code review, discussion, and automated checks before merging.

**PR Workflow:**
```bash
# 1. Create a feature branch
git checkout -b feature/new-feature

# 2. Make changes and commit
echo "New feature code" > feature.txt
git add feature.txt
git commit -m "feat: add new feature"

# 3. Push the branch
git push -u origin feature/new-feature

# 4. Create PR via GitHub CLI
gh pr create --title "Add new feature" --body "Description of changes"

# 5. Or create manually at github.com
```

**PR Best Practices:**
- **Small PRs** — Keep changes focused (under 400 lines if possible)
- **Descriptive title** — Clearly state what the PR does
- **Detailed description** — Explain why and how
- **Link issues** — Reference related issues (#123)
- **Add reviewers** — Request review from teammates
- **Respond to feedback** — Address all comments

**Reviewing a PR:**
```bash
# Checkout a PR locally
gh pr checkout 42

# View PR changes
gh pr diff 42

# Approve or request changes
gh pr review 42 --approve --body "Looks good!"
gh pr review 42 --request-changes --body "Please fix the typo"
```

**Merging a PR:**

| Merge Method | Description | When to Use |
|-------------|-------------|-------------|
| Merge commit | Preserves all commits | Feature branches |
| Squash and merge | Combines all commits into one | Small fixes |
| Rebase and merge | Linear history without merge commit | Clean history |

```bash
gh pr merge 42 --squash
gh pr merge 42 --merge
gh pr merge 42 --rebase
```

**Check Your Understanding:**
- [ ] I can create a pull request from a feature branch
- [ ] I can review someone else's PR
- [ ] I can respond to review feedback
- [ ] I understand the three merge methods
- [ ] I know how to keep PRs small and focused

---

### Day 5-7: Fork Workflow

**Learning Objectives:**
- Fork a repository on GitHub
- Keep your fork in sync with the original
- Contribute to open source projects

**What is a Fork?**
A fork is a copy of someone else's repository under your GitHub account. You can make changes freely without affecting the original.

**Fork Workflow:**
```bash
# 1. Fork the repository on GitHub (click Fork button)

# 2. Clone your fork
git clone https://github.com/YOUR-USERNAME/original-repo.git
cd original-repo

# 3. Add the original repo as upstream
git remote add upstream https://github.com/ORIGINAL-OWNER/original-repo.git

# 4. Create a feature branch
git checkout -b feature/contribution

# 5. Make changes and commit
echo "My contribution" > contribution.txt
git add contribution.txt
git commit -m "feat: add contribution"

# 6. Push to your fork
git push -u origin feature/contribution

# 7. Create a PR from your fork to the original repo
gh pr create --repo ORIGINAL-OWNER/original-repo
```

**Keeping Your Fork in Sync:**
```bash
# Fetch upstream changes
git fetch upstream

# Sync your main branch
git checkout main
git merge upstream/main
git push origin main
```

**Open Source Contribution Tips:**
- Start with `good first issue` or `help wanted` labels
- Read the contributing guidelines first
- Comment on the issue to let others know you are working on it
- Keep your first PR small (documentation fix, typo fix)
- Be respectful and responsive in discussions

**Check Your Understanding:**
- [ ] I can fork a repository on GitHub
- [ ] I can sync my fork with the upstream repository
- [ ] I can submit a PR from my fork to the original repo
- [ ] I understand the difference between fork and branch workflows
- [ ] I know how to find beginner-friendly open source issues

---

## Week 4: Advanced Topics

### Day 1-2: Stashing & Rebase

**Stashing — Temporarily Save Work:**
Stashing lets you save uncommitted changes temporarily so you can switch branches or pull updates without committing half-finished work.

```bash
# Stash current changes
git stash save "WIP: feature in progress"
git stash                   # Short form

# List stashes
git stash list

# Apply the latest stash and remove it
git stash pop

# Apply without removing
git stash apply

# Apply a specific stash
git stash apply stash@{2}

# Drop a stash
git stash drop stash@{2}

# Clear all stashes
git stash clear

# Stash untracked files too
git stash -u
```

**Rebasing — Clean Up History:**
Rebasing rewrites commit history by moving a branch's commits to the tip of another branch. It creates a linear, clean history.

```bash
# Rebase feature branch onto main
git checkout feature/login
git rebase main

# Handle conflicts during rebase
git rebase --continue        # After resolving conflicts
git rebase --skip            # Skip a commit
git rebase --abort           # Cancel the rebase
```

**Rebase vs Merge:**

| Aspect | Merge | Rebase |
|--------|-------|--------|
| History | Preserves branch structure | Linear history |
| Complexity | Simple | More complex |
| Safety | Non-destructive | Rewrites history |
| Best for | Public/shared branches | Local/feature branches |

```bash
# Interactive rebase — squash, reword, reorder commits
git rebase -i HEAD~5        # Rebase last 5 commits

# Options in interactive rebase:
# pick    — Keep the commit as-is
# reword  — Change the commit message
# squash  — Combine with previous commit
# fixup   — Like squash but discard message
# drop    — Remove the commit
```

**Golden Rule of Rebase:** Never rebase commits that have been pushed to a shared branch. Only rebase local or personal feature branches.

**Check Your Understanding:**
- [ ] I can stash and pop changes
- [ ] I can list and manage multiple stashes
- [ ] I can rebase a feature branch onto main
- [ ] I can resolve conflicts during a rebase
- [ ] I know when NOT to rebase

---

### Day 3-4: Cherry-pick & Tags

**Cherry-picking — Selectively Apply Commits:**
Cherry-picking lets you apply a specific commit from one branch to another without merging the entire branch.

```bash
# Cherry-pick a single commit
git cherry-pick <commit-hash>

# Cherry-pick multiple commits
git cherry-pick <hash1> <hash2> <hash3>

# Cherry-pick a range
git cherry-pick <hash1>..<hash3>

# Cherry-pick with options
git cherry-pick --no-commit <hash>   # Apply changes without committing
git cherry-pick --edit <hash>        # Edit commit message
```

**Practice:**
```bash
# Create commits on branch A
git checkout -b branch-a
echo "Feature A1" > a1.txt && git add a1.txt && git commit -m "feat: A1"
echo "Feature A2" > a2.txt && git add a2.txt && git commit -m "feat: A2"

# Switch to main and cherry-pick only A1
git checkout main
git cherry-pick <hash-of-A1-commit>
```

**When to Cherry-pick:**
- Hotfix that needs to go to multiple release branches
- Selectively porting features between branches
- Undoing a commit on one branch but keeping it on another

**Tags — Marking Important Points:**
Tags are reference points that mark specific commits, typically used for releases.

```bash
# Create a lightweight tag
git tag v1.0.0

# Create an annotated tag (recommended)
git tag -a v1.0.0 -m "Release version 1.0.0"

# List tags
git tag
git tag -l "v1.*"           # Filter tags

# View tag details
git show v1.0.0

# Push tags to remote
git push origin v1.0.0
git push origin --tags      # Push all tags

# Delete a tag
git tag -d v1.0.0
git push origin --delete v1.0.0

# Checkout a tag
git checkout v1.0.0
```

**Semantic Versioning:**
```
vMAJOR.MINOR.PATCH
- MAJOR: Breaking changes
- MINOR: New features (backward compatible)
- PATCH: Bug fixes (backward compatible)
```

**Check Your Understanding:**
- [ ] I can cherry-pick a commit from another branch
- [ ] I understand when to use cherry-pick vs merge
- [ ] I can create annotated tags
- [ ] I can push tags to GitHub
- [ ] I understand semantic versioning

---

### Day 5-7: GitHub Actions & Automation

**Learning Objectives:**
- Understand CI/CD concepts
- Create GitHub Actions workflows
- Automate testing, building, and deployment

**What is GitHub Actions?**
GitHub Actions automates software workflows directly in your repository — testing, building, deploying, and more.

**Core Concepts:**

| Concept | Description |
|---------|-------------|
| Workflow | An automated process defined in YAML |
| Job | A set of steps that run on the same runner |
| Step | An individual task (run a command or action) |
| Runner | A server that runs your workflows |
| Action | A reusable unit of code (like a plugin) |
| Event | A trigger that starts a workflow |

**First Workflow:**
Create `.github/workflows/ci.yml`:
```yaml
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run tests
        run: echo "Tests passed!"
```

**Common Workflows:**

```yaml
# Run tests on every push
name: Tests
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
      - run: npm ci
      - run: npm test
```

```yaml
# Deploy to GitHub Pages
name: Deploy
on:
  push:
    branches: [ main ]
permissions:
  contents: read
  pages: write
  id-token: write
jobs:
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/configure-pages@v4
      - uses: actions/upload-pages-artifact@v3
        with:
          path: '.'
      - id: deployment
        uses: actions/deploy-pages@v4
```

**Pre-built Actions:**
```
actions/checkout        — Check out repository
actions/setup-node     — Set up Node.js
actions/setup-python   — Set up Python
actions/upload-artifact — Upload build artifacts
docker/build-push-action — Build and push Docker images
```

**Check Your Understanding:**
- [ ] I understand what CI/CD is and why it matters
- [ ] I can create a simple GitHub Actions workflow
- [ ] I can run tests automatically on push
- [ ] I know how to use pre-built actions
- [ ] I can deploy a site with GitHub Actions

---

## Beyond Week 4

### Month 2: Intermediate Skills

Task tracker for intermediate Git skills:

- [ ] **Interactive rebase** — Squash, reword, reorder commits fluently
- [ ] **Git bisect** — Use binary search to find the commit that introduced a bug
- [ ] **Git hooks** — Automate tasks with pre-commit, commit-msg hooks
- [ ] **Git submodules** — Manage external dependencies within your repo
- [ ] **Git worktrees** — Work on multiple branches simultaneously
- [ ] **Git reflog** — Recover lost commits and undo mistakes
- [ ] **Git LFS** — Handle large files efficiently
- [ ] **Set up CI/CD** — Automate testing and deployment for your projects
- [ ] **GitHub profile README** — Create a standout profile page
- [ ] **Contribute to open source** — Submit PRs to real projects

### Month 3: Advanced Skills

Task tracker for advanced Git skills:

- [ ] **Git internals** — Understand objects, refs, and the .git directory
- [ ] **Custom Git commands** — Write your own Git subcommands
- [ ] **Branch protection rules** — Enforce code review and status checks
- [ ] **Reusable workflows** — Create modular, composable workflows
- [ ] **Release automation** — Automate changelogs, versioning, and publishing
- [ ] **Monorepo management** — Use Turborepo, Nx, or Lerna
- [ ] **Git performance** — Optimize large repositories
- [ ] **Security scanning** — Use CodeQL, Dependabot, and secret scanning
- [ ] **Git subtree** — Alternative to submodules for nested repositories
- [ ] **Custom merge strategies** — Handle complex merge scenarios

---

## Daily Practice Routine

### Morning (15 minutes)

1. Read one documentation page from this site
2. Write down 3 things you learned
3. Review a Git command you are not comfortable with

### During Work

1. Use at least one new Git command you learned
2. Practice branching — create, switch, merge
3. Write meaningful commit messages (use conventional commits)
4. Commit frequently (small, focused commits)

### Evening (15 minutes)

1. Run one example script from the `examples/` directory
2. Complete one exercise from the `exercises/` directory
3. Update your learning log with today progress

---

## Learning Log Template

```markdown
# My Git Learning Log

## Date: YYYY-MM-DD

### What I Learned Today
-
-
-

### Commands I Practiced
-
-

### Challenges I Faced
-

### Goals for Tomorrow
-
-
```

---

## Resources

### Documentation in This Site

| Resource | Description |
|----------|-------------|
| [Beginners Guide](BEGINNERS-GUIDE.md) | Absolute beginner introduction |
| [Complete Git & GitHub Guide](COMPLETE-GIT-GITHUB-GUIDE.md) | Comprehensive full guide |
| [Git Cheatsheet](git-cheatsheet.md) | Quick command reference |
| [Git Visual Guide](GIT-VISUAL-GUIDE.md) | Visual explanations of concepts |
| [Practice Exercises](Practice-Exercises.md) | Exercise tracker and tasks |

### Practice

| Resource | Description |
|----------|-------------|
| `examples/` directory | Ready-to-run practice scripts |
| `exercises/` directory | Step-by-step exercise READMEs |

### External Resources

| Resource | URL | Use |
|----------|-----|-----|
| Learn Git Branching | [learngitbranching.js.org](https://learngitbranching.js.org/) | Interactive visual lessons |
| Oh Shit, Git!?! | [ohshitgit.com](https://ohshitgit.com/) | Common mistakes and fixes |
| GitHub Skills | [skills.github.com](https://skills.github.com/) | Official GitHub tutorials |
| Git Book | [git-scm.com/book](https://git-scm.com/book) | The official Git documentation |

---

## Success Checklist

After completing this learning path, you should be able to:

- [ ] Create and manage Git repositories
- [ ] Use branches effectively for feature development
- [ ] Resolve merge conflicts confidently
- [ ] Collaborate using pull requests and code review
- [ ] Fork repositories and contribute to open source
- [ ] Automate workflows with GitHub Actions
- [ ] Handle advanced Git scenarios (stash, rebase, cherry-pick)
- [ ] Recover from mistakes using reflog and reset
- [ ] Use tags for semantic versioning
- [ ] Set up CI/CD pipelines for your projects
