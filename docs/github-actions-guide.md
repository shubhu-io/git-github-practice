---
layout: single
title: GitHub Actions Guide
---
# GitHub Actions Quick Guide

## Workflow File Location
`.github/workflows/<filename>.yml`

## Basic Structure
```yaml
name: Workflow Name

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  job-name:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Step Name
        run: echo "Hello"
```

## Common Triggers
- `push` - On push to branch
- `pull_request` - On PR event
- `schedule` - Cron-based schedule
- `workflow_dispatch` - Manual trigger

## Common Actions
```yaml
- uses: actions/checkout@v4          # Checkout code
- uses: actions/setup-node@v4        # Setup Node.js
- uses: actions/setup-python@v5      # Setup Python
- uses: actions/cache@v4             # Cache dependencies
```

## Environment Variables
```yaml
env:
  NODE_ENV: production

steps:
  - run: echo ${{ env.NODE_ENV }}
```

## Secrets
```yaml
steps:
  - run: echo ${{ secrets.MY_SECRET }}
```

## Matrix Strategy
```yaml
strategy:
  matrix:
    node-version: [18.x, 20.x]
    os: [ubuntu-latest, windows-latest]
```
