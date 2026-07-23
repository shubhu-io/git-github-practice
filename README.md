# Git & GitHub Practice Repository

A learning and practice repository for Git and GitHub workflows.

> **[View the full documentation site →](https://shubhu-io.github.io/git-github-practice/)**

## Project Structure

```
Git&Github/
├── .github/              # GitHub configuration files
│   ├── ISSUE_TEMPLATE/   # Issue templates
│   ├── workflows/        # GitHub Actions CI/CD
│   └── PULL_REQUEST_TEMPLATE.md
├── src/                  # Source code
├── docs/                 # Documentation site (GitHub Pages)
│   ├── git/              # Git commands reference
│   │   ├── core-commands.md
│   │   ├── branching-merging.md
│   │   ├── remote-operations.md
│   │   ├── undoing-changes.md
│   │   ├── stashing.md
│   │   ├── collaboration.md
│   │   ├── configuration.md
│   │   └── advanced.md
│   ├── github/           # GitHub features reference
│   │   ├── repositories.md
│   │   ├── issues-projects.md
│   │   ├── pull-requests.md
│   │   ├── actions.md
│   │   ├── pages.md
│   │   ├── security.md
│   │   ├── api.md
│   │   ├── cli.md
│   │   └── profiles-orgs.md
│   └── ...
├── scripts/              # Utility scripts
├── tests/                # Test files
├── .gitignore
├── .gitattributes
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

## Quick Start

1. Clone the repository
   ```bash
   git clone https://github.com/username/git-github-practice.git
   ```
2. Navigate to the project
   ```bash
   cd git-github-practice
   ```
3. Create a new branch
   ```bash
   git checkout -b feature/your-feature
   ```

## Documentation Site

Browse all guides online: **[Git & GitHub Learning Hub](https://shubhu-io.github.io/git-github-practice/)**

### Getting Started
| Page | Description |
|------|-------------|
| [Beginner's Guide](docs/BEGINNERS-GUIDE.html) | Step-by-step for absolute beginners — install Git, first commit |
| [Git Cheatsheet](docs/git-cheatsheet.html) | Quick reference of 100+ Git commands |
| [Quick Reference](docs/QUICK-REFERENCE.html) | At-a-glance Git command reference |
| [Git Glossary](docs/GIT-GLOSSARY.html) | Definitions of common Git terminology |
| [FAQ](docs/FAQ.html) | Frequently asked questions |

### Learning Path
| Page | Description |
|------|-------------|
| [Learning Path](docs/Learning-Path.html) | Structured 4-week plan from zero to mastery |

### Guides
| Page | Description |
|------|-------------|
| [Complete Git & GitHub Guide](docs/COMPLETE-GIT-GITHUB-GUIDE.html) | Comprehensive deep-dive into all topics |
| [Git Workflows](docs/GIT-WORKFLOWS.html) | Git Flow, GitHub Flow, trunk-based development |
| [Conventional Commits](docs/CONVENTIONAL-COMMITS.html) | Standardized commit message format |

### GitHub
| Page | Description |
|------|-------------|
| [GitHub Actions Guide](docs/github-actions-guide.html) | Introduction to CI/CD automation |
| [GitHub Actions Advanced](docs/GITHUB-ACTIONS-ADVANCED.html) | Advanced patterns, matrix builds, deployments |
| [GitHub Pages](docs/GITHUB-PAGES.html) | Host static websites for free |
| [Pull Request Guide](docs/GITHUB-PR-GUIDE.html) | Create, review, and merge PRs |
| [GitHub Profile README](docs/GITHUB-PROFILE-README.html) | Create a standout profile README |
| [GitHub REST API](docs/GITHUB-REST-API.html) | Interact with GitHub programmatically |
| [Code Review Guide](docs/CODE-REVIEW-GUIDE.html) | Best practices for reviewing code |

### Advanced Git
| Page | Description |
|------|-------------|
| [Git Aliases](docs/GIT-ALIASES-GUIDE.html) | Speed up your workflow with custom aliases |
| [Git Hooks](docs/GIT-HOOKS-GUIDE.html) | Automate tasks with pre-commit, pre-push hooks |
| [Git Internals](docs/GIT-INTERNALS.html) | How Git works under the hood |
| [Git Performance](docs/GIT-PERFORMANCE-GUIDE.html) | Optimize Git for large repositories |
| [Git Security](docs/GIT-SECURITY-GUIDE.html) | Secure repositories and accounts |
| [Tips & Tricks](docs/GIT-TIPS-TRICKS.html) | Useful Git tips to boost productivity |
| [Visual Guide](docs/GIT-VISUAL-GUIDE.html) | Learn Git through visual diagrams |
| [Troubleshooting](docs/TROUBLESHOOTING.html) | Common Git problems and solutions |

### Resources
| Page | Description |
|------|-------------|
| [Practice Exercises](docs/Practice-Exercises.html) | 20 hands-on exercises |
| [Exercise Solutions](docs/EXERCISES.html) | Solutions to all exercises |
| [Git Scenarios](docs/GIT-SCENARIOS.html) | Real-world scenarios and solutions |
| [Interview Questions](docs/GIT-INTERVIEW-QUESTIONS.html) | 50+ curated interview Q&A |
| [Commands by Task](docs/GIT-COMMANDS-BY-TASK.html) | Commands organized by task |
| [Migration Guide](docs/MIGRATION-GUIDE.html) | Migrate from SVN, Mercurial to Git |
| [Git for Teams](docs/GIT-FOR-TEAMS-GUIDE.html) | Collaborative workflows and best practices |
| [Master Index](docs/Master-Index.html) | Complete overview of every topic |

### Git Commands Reference
| Page | Description |
|------|-------------|
| [Overview](docs/git/) | Git command reference overview |
| [Core Commands](docs/git/core-commands.html) | `init`, `clone`, `add`, `commit`, `status`, `log`, `diff` |
| [Branching & Merging](docs/git/branching-merging.html) | `branch`, `merge`, `rebase`, `switch` |
| [Remote Operations](docs/git/remote-operations.html) | `remote`, `fetch`, `push`, `pull` |
| [Undoing Changes](docs/git/undoing-changes.html) | `reset`, `revert`, `cherry-pick`, `reflog`, `bisect` |
| [Stashing](docs/git/stashing.html) | `stash` with all options |
| [Collaboration](docs/git/collaboration.html) | `tag`, `submodule`, `worktree`, `blame`, `grep` |
| [Configuration](docs/git/configuration.html) | `config`, `help`, `gc`, `fsck` |
| [Advanced](docs/git/advanced.html) | `notes`, `replace`, `filter-branch`, `range-diff` |

### GitHub Features Reference
| Page | Description |
|------|-------------|
| [Overview](docs/github/) | GitHub features reference overview |
| [Repositories](docs/github/repositories.html) | Create, manage, settings, templates |
| [Issues & Projects](docs/github/issues-projects.html) | Issues, labels, milestones, projects |
| [Pull Requests](docs/github/pull-requests.html) | PR workflow, reviews, merge strategies |
| [Actions & CI/CD](docs/github/actions.html) | Workflows, runners, secrets, caching |
| [GitHub Pages](docs/github/pages.html) | Static sites, Jekyll, custom domains |
| [Security](docs/github/security.html) | Dependabot, secrets, code scanning |
| [API](docs/github/api.html) | REST, GraphQL, webhooks |
| [CLI (gh)](docs/github/cli.html) | GitHub CLI commands |
| [Profiles & Orgs](docs/github/profiles-orgs.html) | Profile README, organizations, teams |

## Quick Reference

| Command | Description |
|---------|-------------|
| `git init` | Initialize a new repository |
| `git clone <url>` | Clone a remote repository |
| `git add .` | Stage all changes |
| `git commit -m "msg"` | Commit staged changes |
| `git push` | Push to remote |
| `git pull` | Pull from remote |
| `git branch` | List/create branches |
| `git checkout -b <name>` | Create and switch to a branch |
| `git merge <branch>` | Merge a branch |
| `git stash` | Stash changes temporarily |

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.
