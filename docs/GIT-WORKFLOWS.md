# Git Workflows Guide

This document describes common Git workflows used in software development teams.

---

## Table of Contents

1. [Centralized Workflow](#centralized-workflow)
2. [Feature Branch Workflow](#feature-branch-workflow)
3. [Gitflow Workflow](#gitflow-workflow)
4. [Forking Workflow](#forking-workflow)
5. [Trunk-Based Development](#trunk-based-development)

---

## Centralized Workflow

The simplest workflow, similar to SVN. Everyone works on the same branch.

### When to Use
- Small teams (2-5 developers)
- Short-term projects
- Simple projects with minimal branching needs

### How It Works
```bash
# 1. Pull latest changes
git pull origin main

# 2. Make your changes
# ... edit files ...

# 3. Stage and commit
git add .
git commit -m "feat: add new feature"

# 4. Push to remote
git push origin main
```

### Pros
- Simple and easy to understand
- No branch management overhead

### Cons
- Merge conflicts can be frequent
- No isolated development
- Risk of breaking main branch

---

## Feature Branch Workflow

Each feature is developed in a dedicated branch. Most common workflow.

### When to Use
- Medium to large teams
- Projects with multiple features in development
- Teams that want isolated development

### How It Works
```bash
# 1. Create a feature branch from main
git checkout main
git pull origin main
git checkout -b feature/user-authentication

# 2. Work on your feature
# ... edit files ...

# 3. Commit changes
git add .
git commit -m "feat: add user authentication"

# 4. Push branch to remote
git push -u origin feature/user-authentication

# 5. Create a Pull Request on GitHub
# (or use GitHub CLI)
gh pr create --title "Add user authentication" --body "Description here"

# 6. After code review and approval, merge the PR
# 7. Clean up
git checkout main
git pull origin main
git branch -d feature/user-authentication
```

### Pros
- Isolated development
- Easy code review via Pull Requests
- Clean main branch history

### Cons
- Requires branch management
- Can have many long-lived branches

---

## Gitflow Workflow

A strict branching model designed around project releases.

### Branch Types
- **main**: Production-ready code
- **develop**: Integration branch for features
- **feature/**: New features
- **release/**: Release preparation
- **hotfix/**: Emergency fixes

### How It Works

#### Starting a Feature
```bash
# Create feature branch from develop
git checkout develop
git pull origin develop
git checkout -b feature/payment-system

# Work on feature
# ... edit files ...

# Commit and push
git add .
git commit -m "feat: add payment system"
git push -u origin feature/payment-system

# Merge back to develop
git checkout develop
git merge feature/payment-system
git push origin develop
git branch -d feature/payment-system
```

#### Creating a Release
```bash
# Create release branch from develop
git checkout develop
git checkout -b release/1.2.0

# Make release preparations
# ... version bump, final touches ...

# Commit and push
git add .
git commit -m "chore: prepare release 1.2.0"
git push -u origin release/1.2.0

# Merge to main and tag
git checkout main
git merge release/1.2.0
git tag -a v1.2.0 -m "Release version 1.2.0"
git push origin main --tags

# Back-merge to develop
git checkout develop
git merge release/1.2.0
git push origin develop
git branch -d release/1.2.0
```

#### Hotfix
```bash
# Create hotfix from main
git checkout main
git checkout -b hotfix/critical-security-fix

# Fix the issue
# ... edit files ...

# Commit and push
git add .
git commit -m "hotfix: fix critical security vulnerability"
git push -u origin hotfix/critical-security-fix

# Merge to main and tag
git checkout main
git merge hotfix/critical-security-fix
git tag -a v1.2.1 -m "Hotfix version 1.2.1"
git push origin main --tags

# Back-merge to develop
git checkout develop
git merge hotfix/critical-security-fix
git push origin develop
git branch -d hotfix/critical-security-fix
```

### Pros
- Clear structure for releases
- Well-defined branches for different purposes
- Good for projects with scheduled releases

### Cons
- Complex
- Can be overkill for small projects
- Slower development cycle

---

## Forking Workflow

Contributors fork the repository and submit Pull Requests.

### When to Use
- Open source projects
- Large teams with external contributors
- Projects with strict code quality requirements

### How It Works

#### First-Time Setup
```bash
# Fork the repository on GitHub (click Fork button)

# Clone YOUR fork
git clone https://github.com/YOUR-USERNAME/repository.git
cd repository

# Add upstream remote
git remote add upstream https://github.com/ORIGINAL-OWNER/repository.git

# Verify remotes
git remote -v
```

#### Working on Changes
```bash
# 1. Sync your fork with upstream
git fetch upstream
git checkout main
git merge upstream/main
git push origin main

# 2. Create a feature branch
git checkout -b feature/my-contribution

# 3. Make your changes
# ... edit files ...

# 4. Commit and push
git add .
git commit -m "feat: add new feature"
git push origin feature/my-contribution

# 5. Create Pull Request on GitHub
# Go to the original repository and create a PR
```

### Pros
- Clean separation of concerns
- No direct access to main repository needed
- Great for open source

### Cons
- More steps to set up
- Forks can become outdated

---

## Trunk-Based Development

Everyone works on a single branch (main/trunk) with short-lived feature branches.

### When to Use
- CI/CD heavy environments
- Teams with strong testing practices
- Projects with frequent releases

### How It Works
```bash
# 1. Create very short-lived branch (< 1 day)
git checkout main
git pull origin main
git checkout -b feature/small-change

# 2. Make small, incremental changes
# ... edit files ...

# 3. Commit and push
git add .
git commit -m "feat: small incremental change"
git push -u origin feature/small-change

# 4. Create PR and merge quickly
# 5. Delete branch immediately after merge
```

### Key Principles
- Keep branches short-lived (hours, not days)
- Feature flags for incomplete features
- Comprehensive automated testing
- Frequent integration to main

### Pros
- Minimal merge conflicts
- Fast integration
- Simple branching model

### Cons
- Requires strong CI/CD
- Requires good test coverage
- Feature flags add complexity

---

## Choosing a Workflow

| Workflow | Team Size | Release Cycle | Complexity |
|----------|-----------|---------------|------------|
| Centralized | Small (1-5) | Ad-hoc | Low |
| Feature Branch | Medium (5-20) | Weekly/Monthly | Medium |
| Gitflow | Medium-Large | Scheduled | High |
| Forking | Any (OSS) | Variable | Medium |
| Trunk-Based | Any | Continuous | Low |

---

## Best Practices

1. **Keep commits small and focused**
2. **Write meaningful commit messages**
3. **Use Pull Requests for code review**
4. **Keep main branch always deployable**
5. **Delete merged branches promptly**
6. **Use feature flags for incomplete work**
7. **Automate testing and deployment**
8. **Document your workflow**

---

## Additional Resources

- [Git Documentation](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)
- [Atlassian Git Tutorials](https://www.atlassian.com/git/tutorials)
