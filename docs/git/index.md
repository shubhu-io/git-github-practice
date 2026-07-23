---
layout: single
title: "Git Commands Reference"
permalink: /git/
---

# Git Commands Reference

Comprehensive reference of Git commands organized by category.

<div class="svg-diagram">
<img src="{{ '/assets/images/svg/git-workflow.svg' | relative_url }}" alt="Git Workflow Diagram" style="max-width:100%; height:auto; margin: 20px 0;">
</div>

## Categories

| Category | File | Description |
|---|---|---|
| Core Commands | [core-commands.md](core-commands.md) | `init`, `clone`, `add`, `commit`, `status`, `log`, `diff` |
| Branching & Merging | [branching-merging.md](branching-merging.md) | `branch`, `checkout`, `merge`, `rebase`, `switch`, `restore` |
| Remote Operations | [remote-operations.md](remote-operations.md) | `remote`, `fetch`, `push`, `pull`, `ls-remote` |
| Undoing Changes | [undoing-changes.md](undoing-changes.md) | `reset`, `revert`, `cherry-pick`, `reflog`, `bisect` |
| Stashing | [stashing.md](stashing.md) | `stash` (push, pop, apply, drop, list) |
| Collaboration | [collaboration.md](collaboration.md) | `tag`, `submodule`, `worktree`, `blame`, `grep`, `archive` |
| Configuration | [configuration.md](configuration.md) | `config`, `help`, `maintenance`, `gc`, `fsck` |
| Advanced | [advanced.md](advanced.md) | `notes`, `replace`, `filter-branch`, `range-diff`, `interpret-trailers` |

## Quick Reference by Use Case

```bash
# Starting a project
git init               # Create new repo
git clone <url>        # Clone existing repo
git clone <url> --depth 1  # Shallow clone (faster)

# Daily workflow
git add <file>         # Stage changes
git commit -m "msg"    # Commit staged
git pull               # Fetch + merge
git push               # Push commits

# Branching
git branch <name>      # Create branch
git switch <name>      # Switch branch
git merge <branch>     # Merge into current

# Fixing mistakes
git restore <file>     # Discard unstaged changes
git reset HEAD~1       # Undo last commit (keep changes)
git revert <commit>    # Safe undo (new commit)
```

<div class="svg-diagram">
<img src="{{ '/assets/images/svg/git-branching.svg' | relative_url }}" alt="Git Branching Diagram" style="max-width:100%; height:auto; margin: 20px 0;">
</div>

See individual files for full command syntax, options, and examples.
