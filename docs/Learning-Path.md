---
layout: default
title: Learning Path
nav_order: 3
---
# Learning Path for Git & GitHub

A structured guide to mastering Git and GitHub.

## Learning Path Overview

```
Week 1: Basics ─────────────────────────────────────────────┐
  Day 1-2: Installation & Setup                            │
  Day 3-4: Basic Commands (add, commit, status)            │
  Day 5-7: First Repository & Push to GitHub               │
                                                        ────┘
Week 2: Branching & Merging ───────────────────────────────┐
  Day 1-2: Creating & Switching Branches                  │
  Day 3-4: Merging Branches                               │
  Day 5-7: Merge Conflicts & Resolution                   │
                                                        ────┘
Week 3: Collaboration ─────────────────────────────────────┐
  Day 1-2: Remote Repositories                            │
  Day 3-4: Pull Requests                                  │
  Day 5-7: Fork Workflow                                  │
                                                        ────┘
Week 4: Advanced Topics ───────────────────────────────────┐
  Day 1-2: Stashing & Rebase                              │
  Day 3-4: Cherry-pick & Tags                             │
  Day 5-7: GitHub Actions & Automation                    │
                                                        ────┘
```

## Week 1: Git Basics

### Day 1-2: Installation & Setup

**Learn:**
- What is Git and version control
- Install Git on your system
- Configure Git (name, email)

**Practice:**
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --list
```

**Resources:**
- [docs/BEGINNERS-GUIDE.md](BEGINNERS-GUIDE.md)
- [docs/FAQ.md](FAQ.md)

### Day 3-4: Basic Commands

**Learn:**
- `git init` - Initialize repository
- `git add` - Stage changes
- `git commit` - Save changes
- `git status` - Check status
- `git log` - View history

**Practice:**
- Complete [exercises/01-first-commit/](exercises/01-first-commit/)

**Resources:**
- [docs/git-cheatsheet.md](git-cheatsheet.md)
- [docs/QUICK-REFERENCE.md](QUICK-REFERENCE.md)

### Day 5-7: First Repository

**Learn:**
- Create a new project
- Make commits
- Push to GitHub

**Practice:**
- Create your first repository
- Push to GitHub
- View your repository online

**Resources:**
- [examples/branching.sh](examples/branching.sh)

## Week 2: Branching & Merging

### Day 1-2: Creating & Switching Branches

**Learn:**
- What are branches
- Create branches
- Switch between branches

**Practice:**
- Complete [exercises/02-branching/](exercises/02-branching/)

**Resources:**
- [docs/GIT-SCENARIOS.md](GIT-SCENARIOS.md)

### Day 3-4: Merging Branches

**Learn:**
- Fast-forward merge
- Three-way merge
- Merge commits

**Practice:**
- Create a feature branch
- Make changes
- Merge back to main

### Day 5-7: Merge Conflicts

**Learn:**
- What causes conflicts
- How to resolve conflicts
- Best practices

**Practice:**
- Complete [exercises/03-merge-conflicts/](exercises/03-merge-conflicts/)
- Run [examples/merge-conflict.sh](examples/merge-conflict.sh)

**Resources:**
- [docs/TROUBLESHOOTING.md](TROUBLESHOOTING.md)

## Week 3: Collaboration

### Day 1-2: Remote Repositories

**Learn:**
- What are remotes
- `git clone`, `git pull`, `git push`
- `git fetch`

**Practice:**
- Clone a repository
- Make changes and push
- Pull changes from remote

### Day 3-4: Pull Requests

**Learn:**
- What is a pull request
- Creating PRs
- Code review process

**Practice:**
- Complete [exercises/06-pull-requests/](exercises/06-pull-requests/)
- Read [docs/GITHUB-PR-GUIDE.md](GITHUB-PR-GUIDE.md)

### Day 5-7: Fork Workflow

**Learn:**
- Forking repositories
- Keeping forks in sync
- Contributing to open source

**Practice:**
- Run [examples/fork-workflow.sh](examples/fork-workflow.sh)
- Complete [exercises/13-real-project/](exercises/13-real-project/)

**Resources:**
- [docs/GIT-WORKFLOWS.md](GIT-WORKFLOWS.md)

## Week 4: Advanced Topics

### Day 1-2: Stashing & Rebase

**Learn:**
- Git stash
- Git rebase
- Interactive rebase

**Practice:**
- Complete [exercises/05-stash/](exercises/05-stash/)
- Complete [exercises/04-rebase/](exercises/04-rebase/)
- Run [examples/stash-practice.sh](examples/stash-practice.sh)
- Run [examples/rebase-practice.sh](examples/rebase-practice.sh)

### Day 3-4: Cherry-pick & Tags

**Learn:**
- Cherry-picking commits
- Creating tags
- Semantic versioning

**Practice:**
- Complete [exercises/07-cherry-pick/](exercises/07-cherry-pick/)
- Run [examples/cherry-pick.sh](examples/cherry-pick.sh)
- Run [examples/tagging.sh](examples/tagging.sh)

### Day 5-7: GitHub Actions & Automation

**Learn:**
- What are GitHub Actions
- Creating workflows
- CI/CD basics

**Practice:**
- Read [docs/github-actions-guide.md](github-actions-guide.md)
- Read [docs/GITHUB-ACTIONS-ADVANCED.md](GITHUB-ACTIONS-ADVANCED.md)
- Review `.github/workflows/` directory

## Beyond Week 4

### Month 2: Intermediate Skills

- [ ] Master interactive rebase
- [ ] Learn git bisect for debugging
- [ ] Set up GitHub Actions for your projects
- [ ] Contribute to open source projects
- [ ] Create your GitHub profile README

### Month 3: Advanced Skills

- [ ] Learn Git internals
- [ ] Master Git hooks
- [ ] Set up branch protection rules
- [ ] Create reusable workflows
- [ ] Automate releases

## Daily Practice Routine

### Morning (15 minutes)
1. Read one doc file
2. Note 3 things you learned

### During Work
1. Use Git commands you learned
2. Practice branching
3. Create meaningful commits

### Evening (15 minutes)
1. Run one example script
2. Complete one exercise
3. Update your learning log

## Learning Log Template

```markdown
# Git Learning Log

## Date: YYYY-MM-DD

### What I Learned
- 
- 
- 

### Commands Practiced
- 
- 

### Challenges
- 

### Goals for Tomorrow
- 
- 
```

## Resources

### Documentation
- [docs/BEGINNERS-GUIDE.md](BEGINNERS-GUIDE.md) - Start here
- [docs/COMPLETE-GIT-GITHUB-GUIDE.md](COMPLETE-GIT-GITHUB-GUIDE.md) - Full guide
- [docs/GIT-CHEATSHEET.md](git-cheatsheet.md) - Quick reference
- [docs/GIT-VISUAL-GUIDE.md](GIT-VISUAL-GUIDE.md) - Visual explanations

### Practice
- [examples/](examples/) - Practice scripts
- [exercises/](exercises/) - Step-by-step exercises

### External Resources
- [Learn Git Branching](https://learngitbranching.js.org/) - Interactive
- [Oh Shit, Git!?!](https://ohshitgit.com/) - Common mistakes
- [GitHub Skills](https://skills.github.com/) - Official tutorials

## Success Metrics

After completing this learning path, you should be able to:

- [ ] Create and manage Git repositories
- [ ] Use branches effectively
- [ ] Resolve merge conflicts
- [ ] Collaborate using pull requests
- [ ] Fork and contribute to repositories
- [ ] Use GitHub Actions
- [ ] Handle advanced Git scenarios
