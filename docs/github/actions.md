# GitHub Actions

## Workflow Basics

YAML files in `.github/workflows/`:

```yaml
name: CI
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm install && npm test
```

### Trigger Events (`on:`)

```yaml
on: push                              # Any push
on: [push, pull_request]              # Multiple events
on:
  push:
    branches: [main, develop]         # Specific branches
    tags: ['v*']                      # Tag pushes
    paths: ['src/**']                 # Path filters
  pull_request:
    types: [opened, synchronize, reopened]
  schedule:
    - cron: '0 0 * * *'              # Daily at midnight
  workflow_dispatch:                  # Manual trigger
  repository_dispatch:                # External API trigger
  release:
    types: [published]                # Release events
  issues:
    types: [opened]                   # Issue events
  discussion:
    types: [created]                  # Discussion events
```

### Runners

```yaml
runs-on: ubuntu-latest                # GitHub-hosted
runs-on: ubuntu-22.04                 # Specific version
runs-on: windows-latest               # Windows
runs-on: macos-latest                 # macOS
runs-on: self-hosted                  # Custom runner
runs-on: [self-hosted, linux, x64]    # Label-based
```

## Jobs & Steps

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    timeout-minutes: 10               # Fail after 10 min
    continue-on-error: true           # Don't fail workflow
    if: github.ref == 'refs/heads/main'  # Conditional
    env:                              # Job-level env
      NODE_ENV: test

    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
      - run: npm ci
      - run: npm test
        env:                          # Step-level env
          CI: true

      - uses: actions/upload-artifact@v4
        if: always()                  # Run regardless of outcome
        with:
          name: test-results
          path: junit.xml
```

### Dependencies

```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
  test:
    needs: lint                       # Wait for lint
    runs-on: ubuntu-latest
  deploy:
    needs: [lint, test]               # Wait for both
    if: github.ref == 'refs/heads/main'
```

## Matrices

```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest]
    node: [18, 20, 22]
    include:                          # Add extra config
      - os: ubuntu-latest
        node: 20
        experimental: true
    exclude:                          # Remove combinations
      - os: windows-latest
        node: 18
  fail-fast: false                    # Don't cancel all on one failure
```

## Caching

```yaml
- uses: actions/cache@v4
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-node-
```

## Secrets & Variables

```bash
# Set secrets
gh secret set MY_SECRET
gh secret set NPM_TOKEN --body "token"

# Set environment-level secret
gh secret set DEPLOY_KEY --env production

# Set variables
gh variable set MY_VAR --body "value"

# List
gh secret list
gh variable list
```

### In Workflows

```yaml
steps:
  - run: echo "${{ secrets.MY_SECRET }}"
  - run: echo "${{ vars.MY_VAR }}"
```

## Custom Actions

### Local Action (in repo)
```yaml
# .github/actions/deploy/action.yml
name: Deploy
inputs:
  target:
    required: true
runs:
  using: composite
  steps:
    - run: echo "Deploying to ${{ inputs.target }}"
      shell: bash
```

### Docker Action
```yaml
runs:
  using: docker
  image: Dockerfile
```

## Managed Workflows

```yaml
jobs:
  dependabot:
    permissions:
      contents: write
      pull-requests: write
    steps:
      - uses: dependabot/fetch-metadata@v2
```

## Reusable Workflows

```yaml
# Caller
jobs:
  call-workflow:
    uses: owner/repo/.github/workflows/reusable.yml@main
    with:
      node-version: 20
    secrets:
      NPM_TOKEN: ${{ secrets.NPM_TOKEN }}

# Reusable workflow
on:
  workflow_call:
    inputs:
      node-version:
        required: true
        type: string
    secrets:
      NPM_TOKEN:
        required: true
```
