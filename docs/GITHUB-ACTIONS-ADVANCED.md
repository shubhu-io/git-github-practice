---
layout: single
title: GitHub Actions Advanced
---
# Advanced GitHub Actions Guide

Advanced GitHub Actions concepts and patterns.

## Reusable Workflows

Create workflows that can be reused across repositories.

### Creating a Reusable Workflow

```yaml
# .github/workflows/reusable-build.yml
name: Reusable Build

on:
  workflow_call:
    inputs:
      node-version:
        required: false
        type: string
        default: '20'
    secrets:
      npm-token:
        required: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ inputs.node-version }}
      - run: npm ci
        env:
          NODE_AUTH_TOKEN: ${{ secrets.npm-token }}
      - run: npm test
```

### Using a Reusable Workflow

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main]

jobs:
  build:
    uses: ./.github/workflows/reusable-build.yml
    with:
      node-version: '20'
    secrets:
      npm-token: ${{ secrets.NPM_TOKEN }}
```

## Matrix Strategy

Test across multiple environments.

```yaml
name: Matrix Test

on: push

jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node-version: [18.x, 20.x, 22.x]
      fail-fast: false

    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
      - run: npm ci
      - run: npm test
```

## Caching

Speed up workflows by caching dependencies.

```yaml
steps:
  - uses: actions/checkout@v4
  
  - name: Cache node modules
    uses: actions/cache@v4
    with:
      path: ~/.npm
      key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
      restore-keys: |
        ${{ runner.os }}-node-
  
  - run: npm ci
```

## Conditional Execution

```yaml
steps:
  - name: Run on main only
    if: github.ref == 'refs/heads/main'
    run: echo "This runs only on main"

  - name: Run on PR
    if: github.event_name == 'pull_request'
    run: echo "This runs on PRs"

  - name: Skip for bot commits
    if: "!contains(github.event.head_commit.author.name, 'bot')"
    run: echo "Skip bot commits"
```

## Environment Variables

```yaml
env:
  GLOBAL_VAR: value

jobs:
  build:
    runs-on: ubuntu-latest
    env:
      JOB_VAR: value
    
    steps:
      - run: echo ${{ env.GLOBAL_VAR }}
      - run: echo ${{ env.JOB_VAR }}
      - run: echo ${{ github.sha }}
```

## Secrets Management

```yaml
steps:
  - name: Use secret
    run: echo "Token is ${{ secrets.API_TOKEN }}"
    env:
      API_TOKEN: ${{ secrets.API_TOKEN }}
```

### Creating Environments

1. Go to **Settings** > **Environments**
2. Click **New environment**
3. Add secrets and protection rules

## Job Dependencies

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Building..."

  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - run: echo "Testing..."

  deploy:
    needs: [build, test]
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying..."
```

## Composite Actions

Create custom actions within a workflow.

```yaml
# .github/actions/setup-project/action.yml
name: Setup Project
description: Setup Node.js and install dependencies

inputs:
  node-version:
    description: Node.js version
    default: '20'

runs:
  using: composite
  steps:
    - uses: actions/setup-node@v4
      with:
        node-version: ${{ inputs.node-version }}
    - run: npm ci
      shell: bash
```

### Using Composite Action

```yaml
steps:
  - uses: actions/checkout@v4
  - uses: ./.github/actions/setup-project
    with:
      node-version: '20'
```

## Artifacts

Share data between jobs.

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo "artifact" > file.txt
      - uses: actions/upload-artifact@v4
        with:
          name: my-artifact
          path: file.txt

  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: my-artifact
      - run: cat file.txt
```

## Workflow Dispatch (Manual Triggers)

```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Deploy to environment'
        required: true
        default: 'staging'
        type: choice
        options:
          - staging
          - production

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying to ${{ inputs.environment }}"
```

## Scheduled Workflows

```yaml
on:
  schedule:
    - cron: '0 0 * * *'  # Daily at midnight
    - cron: '0 12 * * 1' # Weekly on Monday at noon

jobs:
  cleanup:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Running scheduled task"
```

## Concurrency Control

```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo "This will cancel previous runs"
```

## Advanced Examples

### Auto-label PRs

```yaml
name: Auto Label PR

on:
  pull_request:
    types: [opened, synchronize]

jobs:
  label:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/labeler@v5
        with:
          repo-token: ${{ secrets.GITHUB_TOKEN }}
```

### Auto-assign Reviewers

```yaml
name: Auto Assign Reviewers

on:
  pull_request:
    types: [opened]

jobs:
  assign:
    runs-on: ubuntu-latest
    steps:
      - uses: kentaro-m/auto-assign-action@v2
        with:
          assignees: ${{ github.actor }}
```

### Release Automation

```yaml
name: Release

on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: softprops/action-gh-release@v1
        with:
          generate_release_notes: true
```

## Best Practices

1. **Use caching** - Speed up builds
2. **Minimize API calls** - Batch operations
3. **Use reusable workflows** - DRY principle
4. **Set timeouts** - Prevent hung jobs
5. **Use concurrency** - Prevent duplicate runs
6. **Store secrets securely** - Never commit them
7. **Use matrix wisely** - Balance coverage vs speed
8. **Monitor costs** - Private repos have limits

## Resources

- [GitHub Actions Documentation](https://docs.github.com/actions)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)
- [Awesome GitHub Actions](https://github.com/sdras/awesome-actions)
