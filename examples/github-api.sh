#!/bin/bash
# GitHub API automation examples using GitHub CLI (gh)

set -e

# Configuration
REPO="owner/repo"

# ============================================
# Issue Management
# ============================================

create_issue() {
    local title="$1"
    local body="$2"
    local labels="${3:-bug}"
    
    gh issue create \
        --title "$title" \
        --body "$body" \
        --label "$labels" \
        --repo "$REPO"
}

close_issue() {
    local issue_number="$1"
    gh issue close "$issue_number" --repo "$REPO"
}

list_issues() {
    local state="${1:-open}"
    gh issue list --state "$state" --repo "$REPO"
}

add_comment() {
    local issue_number="$1"
    local comment="$2"
    gh issue comment "$issue_number" --body "$comment" --repo "$REPO"
}

# ============================================
# Pull Request Management
# ============================================

create_pr() {
    local title="$1"
    local body="$2"
    local base="${3:-main}"
    local head="${4:-HEAD}"
    
    gh pr create \
        --title "$title" \
        --body "$body" \
        --base "$base" \
        --head "$head" \
        --repo "$REPO"
}

merge_pr() {
    local pr_number="$1"
    local method="${2:-squash}"
    gh pr merge "$pr_number" --"$method" --repo "$REPO"
}

review_pr() {
    local pr_number="$1"
    local verdict="$2"  # approve, request changes, comment
    local comment="$3"
    
    gh pr review "$pr_number" \
        --"$verdict" \
        --body "$comment" \
        --repo "$REPO"
}

list_prs() {
    local state="${1:-open}"
    gh pr list --state "$state" --repo "$REPO"
}

# ============================================
# Release Management
# ============================================

create_release() {
    local tag="$1"
    local title="$2"
    local notes="$3"
    
    gh release create "$tag" \
        --title "$title" \
        --notes "$notes" \
        --repo "$REPO"
}

list_releases() {
    gh release list --repo "$REPO"
}

download_release() {
    local tag="$1"
    gh release download "$tag" --repo "$REPO"
}

# ============================================
# Repository Information
# ============================================

get_repo_info() {
    gh repo view "$REPO" --json name,description,url,stargazerCount,forkCount
}

list_branches() {
    gh api "repos/$REPO/branches" --jq '.[].name'
}

list_contributors() {
    gh api "repos/$REPO/contributors" --jq '.[].login'
}

# ============================================
# Workflow Management
# ============================================

list_workflows() {
    gh workflow list --repo "$REPO"
}

trigger_workflow() {
    local workflow="$1"
    local ref="${2:-main}"
    
    gh workflow run "$workflow" \
        --ref "$ref" \
        --repo "$REPO"
}

list_workflow_runs() {
    local workflow="$1"
    gh run list --workflow "$workflow" --repo "$REPO"
}

watch_workflow_run() {
    local run_id="$1"
    gh run watch "$run_id" --repo "$REPO"
}

# ============================================
# Team Management
# ============================================

list_teams() {
    gh api "orgs/$ORG/teams" --jq '.[].name'
}

add_to_team() {
    local team="$1"
    local username="$2"
    local role="${3:-member}"
    
    gh api "orgs/$ORG/teams/$team/memberships/$username" \
        --method PUT \
        --field role="$role"
}

# ============================================
# Webhook Management
# ============================================

list_webhooks() {
    gh api "repos/$REPO/hooks" --jq '.[].config.url'
}

create_webhook() {
    local url="$1"
    local events="${2:-[\"push\"]}"
    
    gh api "repos/$REPO/hooks" \
        --method POST \
        --field config[url]="$url" \
        --field config[content_type]="json" \
        --field events="$events"
}

# ============================================
# Script Usage Examples
# ============================================

# Create an issue
# create_issue "Bug: Login not working" "Users cannot login with correct credentials" "bug"

# Create a PR
# create_pr "Fix login issue" "Fixed validation logic" "main"

# Create a release
# create_release "v1.0.0" "Version 1.0.0" "Initial release"

# Trigger a workflow
# trigger_workflow "ci.yml" "main"

# ============================================
# Main Menu
# ============================================

show_menu() {
    echo "GitHub Automation Menu"
    echo "====================="
    echo "1. Issue Management"
    echo "2. Pull Request Management"
    echo "3. Release Management"
    echo "4. Repository Information"
    echo "5. Workflow Management"
    echo "6. Exit"
    echo ""
    read -p "Select an option: " choice
    
    case $choice in
        1) issue_menu ;;
        2) pr_menu ;;
        3) release_menu ;;
        4) repo_menu ;;
        5) workflow_menu ;;
        6) exit 0 ;;
        *) echo "Invalid option" ;;
    esac
}

# Run the menu if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    show_menu
fi
