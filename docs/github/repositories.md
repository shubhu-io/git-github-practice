---
layout: single
title: "Repositories"
---

# Repositories

## Creating a Repository

### Via Web
```
New → Repository
  Owner: personal or organization
  Name: kebab-case recommended (e.g., my-awesome-project)
  Description: optional
  Public/Private
  Initialize with: README, .gitignore, license
```

### Via gh CLI
```bash
gh repo create <name>                    # Create + clone locally
gh repo create <name> --public           # Public repo
gh repo create <name> --private          # Private repo
gh repo create <name> --internal         # Internal repo (org only)
gh repo create <name> --template         # Template repo
gh repo create <name> --clone            # Clone to local
gh repo create <name> --description "..." 
gh repo create <name> --gitignore Node
gh repo create <name> --license MIT
```

## Repository Settings

| Setting | Tab | Purpose |
|---|---|---|
| General | Settings → General | Name, description, visibility, features |
| Merge button | Settings → General | Merge strategies (merge, squash, rebase) |
| Branch protection | Settings → Branches | Require PRs, status checks, linear history |
| Tags protection | Settings → Tags | Protect tag patterns |
| Rulesets | Settings → Rules | Advanced branch/tag rules |
| Actions | Settings → Actions | Workflow permissions, runners |
| Pages | Settings → Pages | GitHub Pages source, custom domain |
| Secrets & variables | Settings → Secrets | Actions secrets, Dependabot secrets, Codespaces |
| Environments | Settings → Environments | Deploy branches, protection rules |
| Webhooks | Settings → Webhooks | POST events to external services |
| Deploy keys | Settings → Deploy Keys | Read/write SSH keys for CI |
| Moderation | Settings → Moderation | Interaction limits, code review limits |

## Repository Features

```yaml
# .github/CODEOWNERS — auto-request reviews
*        @team-core
src/api/ @api-team
docs/    @docs-team
```

```yaml
# .github/FUNDING.yml — sponsor button
github: username
patreon: username
custom: https://example.com
```

## Repository Templates

Create a template repo to bootstrap new projects:

```bash
# Mark as template on GitHub: Settings → Template repository
# Users can: Use this template → Create new repo
# Or via CLI:
gh repo create <name> --template <owner>/<template-repo>
```

## Environments

```bash
gh api repos/:owner/:repo/environments/:name -X PUT
# Then configure protection rules in Settings → Environments
```
