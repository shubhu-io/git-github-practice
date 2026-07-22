# GitHub Security

## Dependabot

Automated dependency updates.

### Configuration

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: npm
    directory: /
    schedule:
      interval: weekly
      day: monday
      time: "09:00"
      timezone: America/New_York
    open-pull-requests-limit: 10
    labels:
      - dependencies
    reviewers:
      - team-lead
    assignees:
      - username
    allow:
      - dependency-type: direct
    ignore:
      - dependency-name: lodash
        versions: [">=4.x"]
    groups:
      dev-deps:
        patterns:
          - "*eslint*"
          - "*prettier*"
      react:
        patterns:
          - "react"
          - "react-dom"
```

### Ecosystems

npm, pip, maven, gradle, nuget, cargo, docker, terraform, go, etc.

### Security Updates

```
Settings → Security → Dependabot → Dependabot alerts
Settings → Security → Dependabot → Dependabot security updates
```

## Secrets

Store sensitive values for Actions and Codespaces.

```bash
# Repository secrets
gh secret set MY_SECRET
gh secret set NPM_TOKEN --body "npm_abc123"

# Environment secrets
gh secret set DEPLOY_KEY --env production

# Organization secrets
gh secret set MY_SECRET --org my-org

# Dependabot secrets
gh secret set MY_SECRET --app dependabot

# Codespaces secrets
gh secret set MY_SECRET --app codespaces

# List secrets
gh secret list
```

## Secret Scanning

```
Settings → Security → Secret scanning
  - Push protection: Prevents committing secrets
  - Patterns: GitHub, partner patterns, custom patterns
```

## Code Scanning

Static analysis using CodeQL.

```yaml
# .github/workflows/codeql.yml
name: CodeQL
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 0 * * 0'

jobs:
  analyze:
    runs-on: ubuntu-latest
    permissions:
      security-events: write
    steps:
      - uses: actions/checkout@v4
      - uses: github/codeql-action/init@v3
        with:
          languages: javascript
      - uses: github/codeql-action/analyze@v3
```

## Branch Protection

```
Settings → Branches → Branch protection rules

Rules:
  ✓ Require pull request reviews (1-6)
  ✓ Dismiss stale reviews
  ✓ Require status checks
  ✓ Require conversation resolution
  ✓ Require signed commits
  ✓ Require linear history
  ✓ Require merge queue
  ✓ Do not allow bypassing
  ✓ Restrict deletions
  ✓ Lock branch
```

## Push Protection

Prevent accidental commits of secrets:

```
Settings → Security → Secret scanning → Push protection
  ✓ Enable push protection
```

## Code Review Limits

```
Settings → Moderation → Code review limits
  - Limit review requests (members only)
```

## Security Overview

For organizations:

```
https://github.com/organizations/<org>/settings/security
  - Coverage
  - Alerts
  - Dependabot
  - Code scanning
  - Secret scanning
```

## Advisory Database

```
https://github.com/advisories
  - Browse security advisories
  - Report a vulnerability (privately)
```
