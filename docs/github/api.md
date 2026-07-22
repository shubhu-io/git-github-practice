# GitHub API

## REST API

Base URL: `https://api.github.com`

```bash
# Get user
curl -H "Authorization: token <token>" https://api.github.com/user

# List repo issues
curl https://api.github.com/repos/owner/repo/issues

# Create issue
curl -X POST https://api.github.com/repos/owner/repo/issues \
  -H "Authorization: token <token>" \
  -d '{"title":"Bug","body":"Description"}'
```

### Through gh CLI
```bash
gh api /user                              # GET current user
gh api /repos/:owner/:repo                # GET repo info
gh api /repos/:owner/:repo/issues         # GET issues
gh api /repos/:owner/:repo/pulls          # GET PRs
gh api /repos/:owner/:repo/actions/workflows  # GET workflows
gh api /search/repos -q "q=git+topic"     # Search repos

# POST (create)
gh api repos/:owner/:repo/issues -X POST \
  -f title="Bug" \
  -f body="Description"

# PATCH (update)
gh api repos/:owner/:repo/issues/1 -X PATCH \
  -f state=closed

# DELETE
gh api repos/:owner/:repo/git/refs/heads/branch -X DELETE

# Pagination
gh api /repos/:owner/:repo/issues --paginate

# Raw response
gh api /user --jq '.login'
gh api /user --template '{{.login}}'
```

### Authentication

```bash
# Personal Access Token (PAT)
# Settings → Developer settings → Personal access tokens → Fine-grained tokens

# gh auth
gh auth login                              # Authenticate gh CLI
gh auth status                             # Check auth status
gh auth token                              # Show current token
```

### Pagination

```bash
# Link header
curl -I "https://api.github.com/repos/owner/repo/issues?per_page=100"

# gh pagination
gh api /repos/:owner/:repo/issues --paginate
```

### Rate Limits

```bash
gh api /rate_limit                         # Check rate limit
# Unauthenticated: 60 req/hour
# Authenticated: 5,000 req/hour
```

## GraphQL API

Endpoint: `POST https://api.github.com/graphql`

```graphql
query {
  repository(owner: "owner", name: "repo") {
    name
    stargazerCount
    issues(first: 10) {
      nodes { title state }
    }
  }
}
```

```bash
gh api graphql -f query='
  query {
    viewer { login }
  }
'

# With variables
gh api graphql -f query='
  query($owner:String!,$repo:String!) {
    repository(owner:$owner,name:$repo) { name }
  }
' -f owner=shubhu-io -f repo=git-github-practice
```

## Webhooks

Receive HTTP POST when events happen.

```bash
# Create webhook
gh api repos/:owner/:repo/hooks -X POST \
  -f name=web \
  -f config[url]=https://example.com/webhook \
  -f config[content_type]=json \
  -f config[secret]=mysecret \
  -f events='["push","pull_request"]' \
  -f active=true

# List webhooks
gh api repos/:owner/:repo/hooks

# Test webhook
gh api repos/:owner/:repo/hooks/:id/events -X POST
```

### Events

`push`, `pull_request`, `issues`, `workflow_run`, `create`, `delete`, `release`, `star`, `fork`, `watch`, `discussion`, `sponsorship`, `check_run`, `deployment`, `page_build`, `status`, `team_add`

## Checks API

```bash
gh api repos/:owner/:repo/check-runs -X POST \
  -f name="lint" \
  -f head_sha=<sha> \
  -f status=completed \
  -f conclusion=success
```

## Environments API

```bash
# List environments
gh api repos/:owner/:repo/environments

# Create/update environment
gh api repos/:owner/:repo/environments/production -X PUT
```
