---
title: GitHub REST API
---
# GitHub REST API Guide

A comprehensive guide to using the GitHub REST API.

## Getting Started

### Authentication

#### Personal Access Token

```bash
# Create token at GitHub > Settings > Developer settings > Personal access tokens

# Use token
curl -H "Authorization: Bearer YOUR_TOKEN" https://api.github.com/user
```

#### Using GitHub CLI

```bash
# Login
gh auth login

# Use API
gh api /user
```

### Base URL

```
https://api.github.com
```

## Common Endpoints

### Repositories

```bash
# List user repositories
curl -H "Authorization: Bearer TOKEN" \
  https://api.github.com/user/repos

# Get a repository
curl https://api.github.com/repos/OWNER/REPO

# Create a repository
curl -X POST \
  -H "Authorization: Bearer TOKEN" \
  -d '{"name":"new-repo","auto_init":true}' \
  https://api.github.com/user/repos
```

### Pull Requests

```bash
# List pull requests
curl https://api.github.com/repos/OWNER/REPO/pulls

# Create a pull request
curl -X POST \
  -H "Authorization: Bearer TOKEN" \
  -d '{"title":"New feature","head":"feature","main":"main"}' \
  https://api.github.com/repos/OWNER/REPO/pulls

# Get a pull request
curl https://api.github.com/repos/OWNER/REPO/pulls/123
```

### Issues

```bash
# List issues
curl https://api.github.com/repos/OWNER/REPO/issues

# Create an issue
curl -X POST \
  -H "Authorization: Bearer TOKEN" \
  -d '{"title":"Bug report","body":"Description here"}' \
  https://api.github.com/repos/OWNER/REPO/issues

# Update an issue
curl -X PATCH \
  -H "Authorization: Bearer TOKEN" \
  -d '{"state":"closed"}' \
  https://api.github.com/repos/OWNER/REPO/issues/123
```

### Commits

```bash
# List commits
curl https://api.github.com/repos/OWNER/REPO/commits

# Get a commit
curl https://api.github.com/repos/OWNER/REPO/COMMIT_SHA
```

## GitHub CLI Examples

### Repository Operations

```bash
# List repos
gh repo list

# Create repo
gh repo create my-repo --public

# Clone repo
gh repo clone owner/repo

# Fork repo
gh repo fork owner/repo
```

### Pull Request Operations

```bash
# List PRs
gh pr list

# Create PR
gh pr create --title "Feature" --body "Description"

# View PR
gh pr view 123

# Merge PR
gh pr merge 123

# Checkout PR
gh pr checkout 123
```

### Issue Operations

```bash
# List issues
gh issue list

# Create issue
gh issue create --title "Bug" --body "Description"

# View issue
gh issue view 123

# Close issue
gh issue close 123
```

## Using with JavaScript

### Fetch API

```javascript
// Get repository info
const response = await fetch('https://api.github.com/repos/OWNER/REPO', {
  headers: {
    'Authorization': 'Bearer YOUR_TOKEN',
    'Accept': 'application/vnd.github.v3+json'
  }
});
const repo = await response.json();
console.log(repo.stargazers_count);
```

### Octokit.js

```javascript
import { Octokit } from '@octokit/rest';

const octokit = new Octokit({ auth: 'YOUR_TOKEN' });

// List repositories
const { data: repos } = await octokit.repos.listForAuthenticatedUser();

// Create an issue
await octokit.issues.create({
  owner: 'OWNER',
  repo: 'REPO',
  title: 'New Issue',
  body: 'Issue description'
});
```

## Using with Python

### requests

```python
import requests

headers = {
    'Authorization': 'Bearer YOUR_TOKEN',
    'Accept': 'application/vnd.github.v3+json'
}

# Get repository
response = requests.get(
    'https://api.github.com/repos/OWNER/REPO',
    headers=headers
)
repo = response.json()
print(repo['stargazers_count'])
```

### PyGithub

```python
from github import Github

g = Github("YOUR_TOKEN")
repo = g.get_repo("OWNER/REPO")

# List issues
for issue in repo.get_issues():
    print(issue.title)

# Create issue
repo.create_issue(title="New Issue", body="Description")
```

## Webhooks

### Setting Up Webhooks

```bash
# Create webhook
curl -X POST \
  -H "Authorization: Bearer TOKEN" \
  -d '{
    "name": "web",
    "config": {
      "url": "https://your-server.com/webhook",
      "content_type": "json"
    },
    "events": ["push", "pull_request"]
  }' \
  https://api.github.com/repos/OWNER/REPO/hooks
```

### Webhook Events

Common events:
- `push` - Code pushed
- `pull_request` - PR opened/updated
- `issues` - Issue created/updated
- `release` - Release published
- `workflow_run` - Workflow completed

### Handling Webhooks (Node.js)

```javascript
const express = require('express');
const crypto = require('crypto');

const app = express();
app.use(express.json());

app.post('/webhook', (req, res) => {
  const signature = req.headers['x-hub-signature-256'];
  const hash = crypto
    .createHmac('sha256', process.env.WEBHOOK_SECRET)
    .update(JSON.stringify(req.body))
    .digest('hex');
  
  if (signature !== `sha256=${hash}`) {
    return res.status(401).send('Invalid signature');
  }
  
  const event = req.headers['x-github-event'];
  const payload = req.body;
  
  switch (event) {
    case 'push':
      console.log('Push to', payload.ref);
      break;
    case 'pull_request':
      console.log('PR', payload.action);
      break;
  }
  
  res.status(200).send('OK');
});

app.listen(3000);
```

## Rate Limits

### Checking Rate Limit

```bash
curl -I -H "Authorization: Bearer TOKEN" \
  https://api.github.com/rate_limit
```

### Rate Limit Headers

```
X-RateLimit-Limit: 5000
X-RateLimit-Remaining: 4999
X-RateLimit-Reset: 1625000000
```

### Handling Rate Limits

```javascript
async function fetchWithRetry(url, options, retries = 3) {
  const response = await fetch(url, options);
  
  if (response.status === 403) {
    const remaining = response.headers.get('x-ratelimit-remaining');
    if (remaining === '0' && retries > 0) {
      const reset = response.headers.get('x-ratelimit-reset');
      const waitTime = (reset * 1000) - Date.now();
      await new Promise(resolve => setTimeout(resolve, waitTime));
      return fetchWithRetry(url, options, retries - 1);
    }
  }
  
  return response;
}
```

## Pagination

```bash
# Get first page
curl https://api.github.com/repos/OWNER/REPO/issues

# Get next page
curl "https://api.github.com/repos/OWNER/REPO/issues?page=2"

# Get all pages
curl "https://api.github.com/repos/OWNER/REPO/issues?per_page=100"
```

### Handling Pagination (JavaScript)

```javascript
async function getAllPages(url) {
  let results = [];
  let page = 1;
  
  while (true) {
    const response = await fetch(`${url}?page=${page}&per_page=100`);
    const data = await response.json();
    
    if (data.length === 0) break;
    
    results = results.concat(data);
    page++;
  }
  
  return results;
}
```

## Best Practices

1. **Use tokens** - For authenticated requests
2. **Respect rate limits** - Don't make too many requests
3. **Use webhooks** - Instead of polling
4. **Cache responses** - Reduce API calls
5. **Handle errors** - Gracefully handle failures
6. **Use pagination** - For large datasets
7. **Store tokens securely** - Never commit them
8. **Use GitHub CLI** - For quick operations

## Resources

- [GitHub REST API Documentation](https://docs.github.com/en/rest)
- [GitHub GraphQL API](https://docs.github.com/en/graphql)
- [GitHub CLI Manual](https://cli.github.com/manual/)
- [Octokit.js](https://github.com/octokit/octokit.js)
