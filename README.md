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
├── docs/                 # Documentation
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

## Git Commands Reference

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
