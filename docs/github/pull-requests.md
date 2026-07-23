---
layout: single
title: "Pull Requests"
---

# Pull Requests

## Creating Pull Requests

```bash
# Via gh CLI
gh pr create \
  --title "Add user auth" \
  --body "Closes #42" \
  --base main \
  --head feature/auth \
  --label "enhancement" \
  --assignee @me \
  --reviewer @team-lead \
  --draft                         # Create as draft

gh pr create --fill              # Auto-fill from commits
gh pr create --web               # Open browser to create
```

### PR Templates

```yaml
# .github/PULL_REQUEST_TEMPLATE.md or .github/pull_request_template.md
## Summary
<!-- Brief description -->

## Changes
- List of changes

## Testing
- [ ] Unit tests pass
- [ ] Manual testing done

## Closes
<!-- Closes #issue-number -->
```

## Reviewing PRs

```bash
gh pr review <number> \
  --approve                        # Approve
gh pr review <number> \
  --comment --body "Looks good"    # Comment
gh pr review <number> \
  --request-changes --body "Fix X" # Request changes
gh pr review <number> \
  --add --body "LGTM"              # Add review comment

gh pr diff <number>                # Show PR diff
gh pr diff <number> -- <file>      # Show file diff
gh pr checks <number>              # List status checks
```

## Managing PRs

```bash
gh pr list                         # List open PRs
gh pr list --state merged          # List merged PRs
gh pr list --state closed          # List closed PRs
gh pr list --label "bug"           # Filter by label
gh pr list --author @me           # My PRs
gh pr list --review-requested @me  # PRs awaiting my review
gh pr list --base main             # PRs targeting main
gh pr list --draft                 # Draft PRs only
gh pr list --limit 50              # Limit results
gh pr view <number>                # View PR details
gh pr view <number> --comments     # With comments
gh pr view -w <number>             # Open in browser
gh pr status                       # Status of relevant PRs
gh pr merge <number>               # Merge PR
gh pr merge <number> --squash     # Squash merge
gh pr merge <number> --rebase     # Rebase merge
gh pr merge <number> --delete-branch  # Delete head branch after
gh pr close <number>               # Close PR without merging
gh pr ready <number>               # Mark draft as ready
gh pr comment <number> --body "..."  # Add comment
```

## Merge Strategies

| Strategy | Command | History |
|---|---|---|
| Merge commit | `gh pr merge` | Preserves all commits + merge commit |
| Squash merge | `gh pr merge --squash` | Single commit |
| Rebase merge | `gh pr merge --rebase` | Linear history |

Configure in Settings → General → Merge button.

## PR Checks & Status

Enable branch protection in Settings → Branches:

```yaml
Required checks:
  - Build / test (passing)
  - Lint / format
  - Code coverage (>=80%)
  - Required reviewers
```

## Code Owners

```yaml
# .github/CODEOWNERS
* @global-owner
*.js @js-owner
docs/* @docs-team
```

## Draft PRs

```bash
gh pr create --draft              # Create draft (can't be merged)
gh pr ready <number>              # Mark as ready for review
```
