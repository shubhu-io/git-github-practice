#!/bin/bash
# Git bot - automated Git operations

set -e

# Configuration
AUTO_ASSIGN=true
AUTO_LABEL=true
AUTO_CLOSE_STALE=true
STALE_DAYS=30

# ============================================
# Auto-assign PRs
# ============================================

auto_assign_pr() {
    local pr_number="$1"
    local repo="$2"
    
    # Get PR details
    local author=$(gh pr view "$pr_number" --repo "$repo" --json author -q '.author.login')
    
    # Assign PR to author
    gh pr edit "$pr_number" --repo "$repo" --add-assignee "$author"
    
    echo "Assigned PR #$pr_number to $author"
}

# ============================================
# Auto-label PRs based on files changed
# ============================================

auto_label_pr() {
    local pr_number="$1"
    local repo="$2"
    
    # Get changed files
    local files=$(gh pr diff "$pr_number" --repo "$repo" --name-only)
    
    # Determine labels
    local labels=()
    
    if echo "$files" | grep -q "\.md$\|\.txt$\|docs/"; then
        labels+=("documentation")
    fi
    
    if echo "$files" | grep -q "\.test\.\|\.spec\.\|__tests__/"; then
        labels+=("tests")
    fi
    
    if echo "$files" | grep -q "\.yml$\|\.yaml$\|Dockerfile\|\.sh$"; then
        labels+=("devops")
    fi
    
    if echo "$files" | grep -q "\.css$\|\.scss$\|\.less$"; then
        labels+=("styles")
    fi
    
    if echo "$files" | grep -q "package\.json\|requirements\.txt\|Cargo\.toml"; then
        labels+=("dependencies")
    fi
    
    # Apply labels
    for label in "${labels[@]}"; do
        gh pr edit "$pr_number" --repo "$repo" --add-label "$label"
    done
    
    echo "Applied labels to PR #$pr_number: ${labels[*]}"
}

# ============================================
# Auto-close stale issues
# ============================================

auto_close_stale() {
    local repo="$1"
    
    # Find stale issues
    local stale_issues=$(gh issue list \
        --repo "$repo" \
        --state open \
        --limit 100 \
        --json number,updatedAt \
        --jq ".[] | select((now - (.updatedAt | fromdateiso8601)) > ($STALE_DAYS * 86400)) | .number")
    
    for issue in $stale_issues; do
        # Add stale label
        gh issue edit "$issue" --repo "$repo" --add-label "stale"
        
        # Add comment
        gh issue comment "$issue" \
            --repo "$repo" \
            --body "This issue has been automatically marked as stale because it has not had recent activity. It will be closed in 7 days if no further activity occurs."
        
        echo "Marked issue #$issue as stale"
    done
}

# ============================================
# Auto-merge PRs with label
# ============================================

auto_merge_approved() {
    local repo="$1"
    
    # Find approved PRs
    local approved_prs=$(gh pr list \
        --repo "$repo" \
        --state open \
        --label "auto-merge" \
        --json number,reviewDecision \
        --jq '.[] | select(.reviewDecision == "APPROVED") | .number')
    
    for pr in $approved_prs; do
        # Check if all checks passed
        local checks=$(gh pr checks "$pr" --repo "$repo" --json name,conclusion -q '.[].conclusion')
        
        if echo "$checks" | grep -q "failure"; then
            echo "PR #$pr has failed checks, skipping"
            continue
        fi
        
        # Merge PR
        gh pr merge "$pr" --repo "$repo" --squash
        
        echo "Auto-merged PR #$pr"
    done
}

# ============================================
# Generate release notes
# ============================================

generate_release_notes() {
    local repo="$1"
    local tag="$2"
    
    # Get commits since last tag
    local last_tag=$(gh release list --repo "$repo" --limit 1 --json tagName -q '.[0].tagName')
    
    if [ -z "$last_tag" ]; then
        local commits=$(gh api "repos/$repo/commits" --jq '.[].commit.message')
    else
        local commits=$(gh api "repos/$repo/compare/$last_tag...$tag" --jq '.commits[].commit.message')
    fi
    
    # Categorize commits
    local features=""
    local fixes=""
    local docs=""
    local other=""
    
    while IFS= read -r commit; do
        if echo "$commit" | grep -q "^feat"; then
            features="$features- ${commit#*: }
"
        elif echo "$commit" | grep -q "^fix"; then
            fixes="$fixes- ${commit#*: }
"
        elif echo "$commit" | grep -q "^docs"; then
            docs="$docs- ${commit#*: }
"
        else
            other="$other- $commit
"
        fi
    done <<< "$commits"
    
    # Generate notes
    local notes="## What's New

$features
## Bug Fixes

$fixes
## Documentation

$docs
## Other Changes

$other"
    
    echo "$notes"
}

# ============================================
# Create PR with template
# ============================================

create_pr_with_template() {
    local repo="$1"
    local title="$2"
    local type="$3"
    
    local body=""
    
    case $type in
        feature)
            body="## Description
Brief description of the feature

## Changes
- Change 1
- Change 2

## Testing
- [ ] Unit tests added
- [ ] Integration tests added
- [ ] Manual testing completed

## Related Issues
Closes #"
            ;;
        bugfix)
            body="## Description
Brief description of the bug fix

## Root Cause
What caused the bug

## Solution
How it was fixed

## Testing
- [ ] Unit tests added
- [ ] Regression test added

## Related Issues
Closes #"
            ;;
        docs)
            body="## Description
Brief description of documentation changes

## Changes
- Change 1
- Change 2

## Related Issues
Closes #"
            ;;
    esac
    
    gh pr create \
        --repo "$repo" \
        --title "$title" \
        --body "$body" \
        --label "$type"
}

# ============================================
# Monitor CI/CD
# ============================================

monitor_workflow() {
    local repo="$1"
    local workflow="$2"
    
    # Get recent runs
    local runs=$(gh run list \
        --repo "$repo" \
        --workflow "$workflow" \
        --limit 5 \
        --json status,conclusion,headBranch,event,createdAt \
        --jq '.[] | "\(.status) \(.conclusion) \(.headBranch) \(.event) \(.createdAt)"')
    
    echo "Recent workflow runs for $workflow:"
    echo ""
    echo "$runs"
}

# ============================================
# Script Usage
# ============================================

usage() {
    echo "Usage: $0 <command> [options]"
    echo ""
    echo "Commands:"
    echo "  auto-assign <pr> <repo>     - Auto-assign PR to author"
    echo "  auto-label <pr> <repo>      - Auto-label PR based on files"
    echo "  auto-close <repo>           - Auto-close stale issues"
    echo "  auto-merge <repo>           - Auto-merge approved PRs"
    echo "  release-notes <repo> <tag>  - Generate release notes"
    echo "  create-pr <repo> <title> <type> - Create PR with template"
    echo "  monitor <repo> <workflow>   - Monitor CI/CD workflow"
}

# Main
if [ $# -lt 1 ]; then
    usage
    exit 1
fi

command="$1"
shift

case $command in
    auto-assign)
        auto_assign_pr "$@"
        ;;
    auto-label)
        auto_label_pr "$@"
        ;;
    auto-close)
        auto_close_stale "$@"
        ;;
    auto-merge)
        auto_merge_approved "$@"
        ;;
    release-notes)
        generate_release_notes "$@"
        ;;
    create-pr)
        create_pr_with_template "$@"
        ;;
    monitor)
        monitor_workflow "$@"
        ;;
    *)
        echo "Unknown command: $command"
        usage
        exit 1
        ;;
esac
