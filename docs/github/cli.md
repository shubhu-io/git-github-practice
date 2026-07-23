---
layout: single
title: "GitHub CLI (gh)"
---

# GitHub CLI (gh)

Command-line interface for GitHub.

## Installation

```bash
# Windows (scoop)
scoop install gh

# Windows (winget)
winget install --id GitHub.cli

# macOS (homebrew)
brew install gh

# Linux (apt)
type -p curl >/dev/null || apt install curl
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
apt update && apt install gh

# Verify
gh --version
```

## Authentication

```bash
gh auth login                            # Interactive login
gh auth login --with-token < token.txt   # Non-interactive
gh auth logout                           # Logout
gh auth status                           # Check auth
gh auth token                            # Show token
gh auth refresh                          # Refresh scopes
```

## Repository Commands

```bash
gh repo create <name>                    # Create repo
gh repo fork <repo>                      # Fork repo
gh repo clone <owner>/<repo>             # Clone repo
gh repo view                             # View current repo
gh repo view <owner>/<repo>              # View repo in browser
gh repo view --web                       # Open in browser
gh repo rename <name>                    # Rename repo
gh repo edit --description "..."         # Edit repo
gh repo edit --visibility private        # Change visibility
gh repo edit --homepage <url>            # Set homepage
gh repo archive                          # Archive repo
gh repo sync                            # Sync fork with upstream
gh repo list                             # List user repos
gh repo list <org>                       # List org repos
```

## Pull Request Commands

```bash
gh pr create                             # Create PR
gh pr list                               # List PRs
gh pr view <number>                      # View PR
gh pr checkout <number>                  # Checkout PR locally
gh pr diff <number>                      # Show diff
gh pr checks <number>                    # List checks
gh pr review <number> --approve          # Approve
gh pr review <number> --comment          # Comment
gh pr merge <number>                     # Merge PR
gh pr merge <number> --squash            # Squash merge
gh pr merge <number> --rebase            # Rebase merge
gh pr close <number>                     # Close PR
gh pr ready <number>                     # Ready for review
gh pr comment <number> --body "..."      # Comment
gh pr edit <number> --add-label "bug"    # Add label
gh pr status                             # PR status overview
```

## Issue Commands

```bash
gh issue create                          # Create issue
gh issue list                            # List issues
gh issue view <number>                   # View issue
gh issue close <number>                  # Close issue
gh issue reopen <number>                 # Reopen issue
gh issue comment <number> --body "..."   # Comment
gh issue edit <number> --add-label "bug" # Add label
gh issue status                          # Issue status
gh issue pin <number>                    # Pin issue
gh issue lock <number>                   # Lock issue
```

## Actions Commands

```bash
gh workflow list                        # List workflows
gh workflow run <name>                  # Run workflow
gh workflow view <name>                 # View workflow
gh run list                             # List recent runs
gh run view <run-id>                    # View run
gh run view <run-id> --log              # View logs
gh run download <run-id>                # Download artifacts
gh run rerun <run-id>                   # Rerun failed jobs
gh run cancel <run-id>                  # Cancel run
gh run watch <run-id>                   # Watch live logs
```

## Release Commands

```bash
gh release create <tag>                 # Create release
gh release list                         # List releases
gh release view                         # View release
gh release download <tag>               # Download assets
gh release upload <tag> <file>          # Upload asset
gh release delete <tag>                 # Delete release
gh release edit <tag> --notes "..."     # Edit notes
```

## Misc Commands

```bash
gh gist create <file>                   # Create gist
gh gist list                            # List gists
gh gist view <id>                       # View gist

gh search repos "topic:git"            # Search repos
gh search issues "bug in:readme"       # Search issues
gh search prs "fix in:title"           # Search PRs

gh codespace list                       # List codespaces
gh codespace create                     # Create codespace
gh codespace code                       # Open in VS Code

gh alias set <name> "<cmd>"            # Create alias
gh alias list                           # List aliases

gh extension list                       # List extensions
gh extension install <owner>/<repo>    # Install extension
```

## Configuration

```bash
gh config set git_protocol ssh          # Use SSH instead of HTTPS
gh config set editor code               # Set editor
gh config set browser firefox           # Set browser
gh config set prompt disabled           # Disable interactive prompts
gh config list                          # Show config
```
