# Issues, Projects & Discussions

## Issues

Track bugs, features, and tasks.

### Creating Issues

```bash
# Via gh CLI
gh issue create \
  --title "Fix login bug" \
  --body "Steps to reproduce..." \
  --label "bug" \
  --assignee @me \
  --project "Q3 Sprint"

# Via URL
# https://github.com/owner/repo/issues/new?title=Fix+bug&labels=bug
```

### Managing Issues

```bash
gh issue list                           # List open issues
gh issue list --state closed            # List closed issues
gh issue list --label "bug"             # Filter by label
gh issue list --assignee @me           # Assigned to me
gh issue list --author @me             # Created by me
gh issue list --limit 50               # Limit results
gh issue view <number>                  # View issue details
gh issue view <number> --comments       # View with comments
gh issue close <number>                 # Close issue
gh issue reopen <number>                # Reopen issue
gh issue comment <number> --body "..."  # Add comment
gh issue edit <number> --add-label "..."  # Add label
gh issue edit <number> --remove-label "..." # Remove label
gh issue lock <number>                  # Lock conversation
gh issue unlock <number>                # Unlock conversation
gh issue pin <number>                   # Pin issue
gh issue unpin <number>                 # Unpin issue
gh issue status                         # Show status of relevant issues
```

### Issue Templates

```yaml
# .github/ISSUE_TEMPLATE/bug_report.yml
name: Bug Report
description: File a bug report
labels: ["bug"]
body:
  - type: textarea
    id: description
    attributes:
      label: Description
      description: What happened?
    validations:
      required: true
  - type: textarea
    id: steps
    attributes:
      label: Steps to reproduce
```

### Labels

| Label | Color | Purpose |
|---|---|---|
| `bug` | #d73a4a | Something isn't working |
| `enhancement` | #a2eeef | New feature or request |
| `documentation` | #0075ca | Improvements to docs |
| `good first issue` | #7057ff | Good for newcomers |
| `help wanted` | #008672 | Extra attention needed |
| `question` | #d876e3 | Further info requested |
| `wontfix` | #ffffff | Won't work on |

## Milestones

```bash
gh api repos/:owner/:repo/milestones -X POST \
  -f title="v2.0" \
  -f description="Release 2.0" \
  -f due_on="2026-12-31T23:59:59Z"
```

## Projects (Beta)

GitHub Projects provide a Kanban-style board.

```bash
gh project list                         # List projects
gh project view <number>                # View project items
gh project item-add <number> --title "Task"  # Add item
gh project item-edit <number> --field "Status" --value "Done"
```

## Discussions

Enable in Settings → General → Discussions.

```bash
gh discussion list                      # List discussions
gh discussion create --title "..." --body "..."
```

Categories: Announcements, Ideas, Q&A, Show and tell, General, Polls
