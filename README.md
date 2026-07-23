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

## Reference

- **[Git Commands Reference](docs/git/)** — Comprehensive Git commands organized by category:
  - [Core Commands](docs/git/core-commands.md) — `init`, `clone`, `add`, `commit`, `status`, `log`, `diff`
  - [Branching & Merging](docs/git/branching-merging.md) — `branch`, `merge`, `rebase`, `switch`
  - [Remote Operations](docs/git/remote-operations.md) — `remote`, `fetch`, `push`, `pull`
  - [Undoing Changes](docs/git/undoing-changes.md) — `reset`, `revert`, `cherry-pick`, `reflog`, `bisect`
  - [Stashing](docs/git/stashing.md) — `stash` with all options
  - [Collaboration](docs/git/collaboration.md) — `tag`, `submodule`, `worktree`, `blame`, `grep`
  - [Configuration](docs/git/configuration.md) — `config`, `help`, `gc`, `fsck`
  - [Advanced](docs/git/advanced.md) — `notes`, `replace`, `filter-branch`, `range-diff`

- **[GitHub Features Reference](docs/github/)** — Comprehensive GitHub features organized by category:
  - [Repositories](docs/github/repositories.md) — Create, manage, settings, templates
  - [Issues & Projects](docs/github/issues-projects.md) — Issues, labels, milestones, projects
  - [Pull Requests](docs/github/pull-requests.md) — PR workflow, reviews, merge strategies
  - [Actions & CI/CD](docs/github/actions.md) — Workflows, runners, secrets, caching
  - [GitHub Pages](docs/github/pages.md) — Static sites, Jekyll, custom domains
  - [Security](docs/github/security.md) — Dependabot, secrets, code scanning
  - [API](docs/github/api.md) — REST, GraphQL, webhooks
  - [CLI (gh)](docs/github/cli.md) — GitHub CLI commands
  - [Profiles & Orgs](docs/github/profiles-orgs.md) — Profile README, organizations, teams

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
