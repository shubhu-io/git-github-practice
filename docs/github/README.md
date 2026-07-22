# GitHub Features Reference

Comprehensive reference of GitHub features, tools, and workflows.

## Categories

| Category | File | Description |
|---|---|---|
| Repositories | [repositories.md](repositories.md) | Create, manage, settings, templates, environments |
| Issues & Projects | [issues-projects.md](issues-projects.md) | Issues, labels, milestones, projects, discussions |
| Pull Requests | [pull-requests.md](pull-requests.md) | PR workflow, reviews, checks, merge strategies |
| Actions & CI/CD | [actions.md](actions.md) | Workflows, events, runners, secrets, caching |
| Pages | [pages.md](pages.md) | Static sites, Jekyll, custom domains, builds |
| Security | [security.md](security.md) | Dependabot, secrets, code scanning, DDoS protection |
| API | [api.md](api.md) | REST API, GraphQL, webhooks, tokens |
| CLI | [cli.md](cli.md) | gh CLI — repos, PRs, issues, actions, API |
| Profiles & Orgs | [profiles-orgs.md](profiles-orgs.md) | Profile README, organizations, teams, permissions |

## Quick Reference

```bash
# gh CLI — most common tasks
gh repo create <name>          # Create repo
gh repo clone <owner>/<repo>   # Clone repo
gh pr create                   # Create PR
gh pr review                   # Review PR
gh issue create                # Create issue
gh workflow run <name>         # Trigger workflow
gh run list                    # List workflow runs
gh secret set <name>           # Set secret
gh api <endpoint>              # Call REST API

# Web features
# Repo: https://github.com/<owner>/<repo>
# Issues: /issues
# PRs: /pulls
# Actions: /actions
# Pages: /pages
# Wiki: /wiki
# Settings: /settings
# Security: /security
```

See individual files for detailed usage, options, and examples.
