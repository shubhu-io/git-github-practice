#!/bin/bash
# ============================================================
# Git & GitHub Master Automation Script
# All-in-one tool for Git operations, GitHub API, and automation
# ============================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuration
REPO="${GITHUB_REPO:-owner/repo}"
ORG="${GITHUB_ORG:-myorg}"

# ============================================================
# Utility Functions
# ============================================================

print_header() {
    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║              $1${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# ============================================================
# Git Operations
# ============================================================

# Quick commit with conventional format
git_quick_commit() {
    local type=$1
    local scope=$2
    local message=$3
    
    if [ -z "$type" ] || [ -z "$message" ]; then
        echo "Usage: quick-commit <type> [scope] <message>"
        echo "Types: feat, fix, docs, style, refactor, perf, test, chore, ci, build"
        return 1
    fi
    
    if [ -n "$scope" ]; then
        git commit -m "$type($scope): $message"
    else
        git commit -m "$type: $message"
    fi
}

# Create feature branch
git_feature() {
    local name=$1
    
    if [ -z "$name" ]; then
        echo "Usage: feature <name>"
        return 1
    fi
    
    git checkout -b "feature/$name"
    print_success "Created feature/$name"
}

# Create hotfix branch
git_hotfix() {
    local name=$1
    
    if [ -z "$name" ]; then
        echo "Usage: hotfix <name>"
        return 1
    fi
    
    git checkout -b "hotfix/$name"
    print_success "Created hotfix/$name"
}

# Smart status
git_smart_status() {
    print_header "Repository Status"
    
    echo -e "${YELLOW}=== Branch Info ===${NC}"
    git branch -v
    
    echo ""
    echo -e "${YELLOW}=== Working Tree ===${NC}"
    git status --short
    
    echo ""
    echo -e "${YELLOW}=== Recent Commits ===${NC}"
    git log --oneline -5
    
    echo ""
    echo -e "${YELLOW}=== Stash ===${NC}"
    git stash list | head -3
}

# Diff with stats
git_diff_stats() {
    echo -e "${YELLOW}=== Diff Statistics ===${NC}"
    git diff --stat $1 $2
    
    echo ""
    echo -e "${YELLOW}=== Summary ===${NC}"
    git diff --shortstat $1 $2
}

# Squash last N commits
git_squash() {
    local count=${1:-2}
    
    if [ "$count" -lt 2 ]; then
        echo "Cannot squash less than 2 commits"
        return 1
    fi
    
    git reset --soft HEAD~$count
    git commit
    print_success "Squashed last $count commits"
}

# Undo last commit (keep changes)
git_undo() {
    git reset --soft HEAD~1
    print_success "Undid last commit (changes preserved)"
}

# Clean untracked files
git_clean_all() {
    echo -e "${YELLOW}This will remove all untracked files!${NC}"
    read -p "Continue? (y/n): " confirm
    
    if [ "$confirm" = "y" ]; then
        git clean -fd
        git checkout -- .
        print_success "Cleaned working directory"
    else
        print_info "Cancelled"
    fi
}

# ============================================================
# GitHub Operations
# ============================================================

# Create issue
gh_create_issue() {
    local title="$1"
    local body="$2"
    local labels="${3:-bug}"
    
    gh issue create \
        --title "$title" \
        --body "$body" \
        --label "$labels" \
        --repo "$REPO"
    
    print_success "Created issue: $title"
}

# Close issue
gh_close_issue() {
    local issue_number="$1"
    gh issue close "$issue_number" --repo "$REPO"
    print_success "Closed issue #$issue_number"
}

# List issues
gh_list_issues() {
    local state="${1:-open}"
    gh issue list --state "$state" --repo "$REPO"
}

# Create PR
gh_create_pr() {
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
    
    print_success "Created PR: $title"
}

# Merge PR
gh_merge_pr() {
    local pr_number="$1"
    local method="${2:-squash}"
    
    gh pr merge "$pr_number" --"$method" --repo "$REPO"
    print_success "Merged PR #$pr_number"
}

# Review PR
gh_review_pr() {
    local pr_number="$1"
    local verdict="$2"
    local comment="$3"
    
    gh pr review "$pr_number" \
        --"$verdict" \
        --body "$comment" \
        --repo "$REPO"
    
    print_success "Reviewed PR #$pr_number"
}

# List PRs
gh_list_prs() {
    local state="${1:-open}"
    gh pr list --state "$state" --repo "$REPO"
}

# Create release
gh_create_release() {
    local tag="$1"
    local title="$2"
    local notes="$3"
    
    gh release create "$tag" \
        --title "$title" \
        --notes "$notes" \
        --repo "$REPO"
    
    print_success "Created release: $tag"
}

# List releases
gh_list_releases() {
    gh release list --repo "$REPO"
}

# ============================================================
# Workflow Operations
# ============================================================

# List workflows
gh_list_workflows() {
    gh workflow list --repo "$REPO"
}

# Trigger workflow
gh_trigger_workflow() {
    local workflow="$1"
    local ref="${2:-main}"
    
    gh workflow run "$workflow" --ref "$ref" --repo "$REPO"
    print_success "Triggered workflow: $workflow"
}

# Watch workflow
gh_watch_workflow() {
    local run_id="$1"
    gh run watch "$run_id" --repo "$REPO"
}

# List workflow runs
gh_list_workflow_runs() {
    local workflow="$1"
    gh run list --workflow "$workflow" --repo "$REPO" --limit 10
}

# ============================================================
# Repository Operations
# ============================================================

# Get repo info
gh_repo_info() {
    gh repo view "$REPO" --json name,description,url,stargazerCount,forkCount,defaultBranchRef
}

# List branches
gh_list_branches() {
    gh api "repos/$REPO/branches" --jq '.[].name'
}

# List contributors
gh_list_contributors() {
    gh api "repos/$REPO/contributors" --jq '.[].login'
}

# ============================================================
# Automation Functions
# ============================================================

# Auto-assign PR to author
gh_auto_assign() {
    local pr_number="$1"
    local author=$(gh pr view "$pr_number" --repo "$REPO" --json author -q '.author.login')
    
    gh pr edit "$pr_number" --repo "$REPO" --add-assignee "$author"
    print_success "Assigned PR #$pr_number to $author"
}

# Auto-label PR based on files
gh_auto_label() {
    local pr_number="$1"
    local files=$(gh pr diff "$pr_number" --repo "$REPO" --name-only)
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
    
    for label in "${labels[@]}"; do
        gh pr edit "$pr_number" --repo "$REPO" --add-label "$label"
    done
    
    print_success "Applied labels to PR #$pr_number: ${labels[*]}"
}

# Close stale issues
gh_close_stale() {
    local days="${1:-30}"
    local stale_issues=$(gh issue list \
        --repo "$REPO" \
        --state open \
        --limit 100 \
        --json number,updatedAt \
        --jq ".[] | select((now - (.updatedAt | fromdateiso8601)) > ($days * 86400)) | .number")
    
    for issue in $stale_issues; do
        gh issue edit "$issue" --repo "$REPO" --add-label "stale"
        gh issue comment "$issue" \
            --repo "$REPO" \
            --body "This issue has been automatically marked as stale."
        print_success "Marked issue #$issue as stale"
    done
}

# Generate release notes
gh_release_notes() {
    local tag="$1"
    local last_tag=$(gh release list --repo "$REPO" --limit 1 --json tagName -q '.[0].tagName')
    
    if [ -z "$last_tag" ]; then
        echo "No previous release found"
        return 1
    fi
    
    echo "## What's New"
    echo ""
    gh api "repos/$REPO/compare/$last_tag...$tag" --jq '.commits[] | select(.commit.message | startswith("feat")) | "- " + (.commit.message | split("\n")[0])'
    
    echo ""
    echo "## Bug Fixes"
    echo ""
    gh api "repos/$REPO/compare/$last_tag...$tag" --jq '.commits[] | select(.commit.message | startswith("fix")) | "- " + (.commit.message | split("\n")[0])'
}

# ============================================================
# Utility Scripts
# ============================================================

# Find large files
git_find_large() {
    local size="${1:-1048576}"  # 1MB default
    
    echo -e "${YELLOW}Finding files larger than $(($size / 1024))KB...${NC}"
    git rev-list --objects --all | \
      git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
      sed -n 's/^blob //p' | \
      awk -v size="$size" '$2 > size {print $0}' | \
      sort -rnk2 | \
      head -20
}

# Check repo size
git_repo_size() {
    echo -e "${YELLOW}Repository Size:${NC}"
    du -sh .git
    
    echo ""
    echo -e "${YELLOW}Object Count:${NC}"
    git count-objects -vH
}

# Setup git aliases
git_setup_aliases() {
    git config --global alias.st "status -sb"
    git config --global alias.co "checkout"
    git config --global alias.br "branch"
    git config --global alias.cm "commit -m"
    git config --global alias.lg "log --oneline --graph --all"
    git config --global alias.last "log -1 HEAD"
    git config --global alias.unstage "reset HEAD --"
    git config --global alias.amend "commit --amend --no-edit"
    git config --global alias.wip "commit -am 'WIP'"
    git config --global alias.undo "reset --soft HEAD~1"
    
    print_success "Git aliases configured"
}

# ============================================================
# Menu System
# ============================================================

show_main_menu() {
    print_header "Git & GitHub Master Tool"
    
    echo -e "${CYAN}1.${NC} Git Operations"
    echo -e "${CYAN}2.${NC} GitHub Operations"
    echo -e "${CYAN}3.${NC} Workflow Operations"
    echo -e "${CYAN}4.${NC} Automation"
    echo -e "${CYAN}5.${NC} Utilities"
    echo -e "${CYAN}6.${NC} Setup"
    echo -e "${CYAN}0.${NC} Exit"
    echo ""
    read -p "Select an option: " choice
    
    case $choice in
        1) show_git_menu ;;
        2) show_github_menu ;;
        3) show_workflow_menu ;;
        4) show_automation_menu ;;
        5) show_utility_menu ;;
        6) show_setup_menu ;;
        0) exit 0 ;;
        *) echo "Invalid option"; show_main_menu ;;
    esac
}

show_git_menu() {
    print_header "Git Operations"
    
    echo -e "${CYAN}1.${NC} Quick Commit"
    echo -e "${CYAN}2.${NC} Create Feature Branch"
    echo -e "${CYAN}3.${NC} Create Hotfix Branch"
    echo -e "${CYAN}4.${NC} Smart Status"
    echo -e "${CYAN}5.${NC} Diff Stats"
    echo -e "${CYAN}6.${NC} Squash Commits"
    echo -e "${CYAN}7.${NC} Undo Last Commit"
    echo -e "${CYAN}8.${NC} Clean Working Directory"
    echo -e "${CYAN}0.${NC} Back"
    echo ""
    read -p "Select an option: " choice
    
    case $choice in
        1)
            read -p "Type (feat/fix/docs): " type
            read -p "Scope (optional): " scope
            read -p "Message: " message
            git_quick_commit "$type" "$scope" "$message"
            ;;
        2)
            read -p "Feature name: " name
            git_feature "$name"
            ;;
        3)
            read -p "Hotfix name: " name
            git_hotfix "$name"
            ;;
        4) git_smart_status ;;
        5) git_diff_stats ;;
        6)
            read -p "Number of commits to squash (default 2): " count
            git_squash "${count:-2}"
            ;;
        7) git_undo ;;
        8) git_clean_all ;;
        0) show_main_menu ;;
        *) echo "Invalid option"; show_git_menu ;;
    esac
    
    show_git_menu
}

show_github_menu() {
    print_header "GitHub Operations"
    
    echo -e "${CYAN}1.${NC} Create Issue"
    echo -e "${CYAN}2.${NC} Close Issue"
    echo -e "${CYAN}3.${NC} List Issues"
    echo -e "${CYAN}4.${NC} Create PR"
    echo -e "${CYAN}5.${NC} Merge PR"
    echo -e "${CYAN}6.${NC} Review PR"
    echo -e "${CYAN}7.${NC} List PRs"
    echo -e "${CYAN}8.${NC} Create Release"
    echo -e "${CYAN}9.${NC} List Releases"
    echo -e "${CYAN}0.${NC} Back"
    echo ""
    read -p "Select an option: " choice
    
    case $choice in
        1)
            read -p "Title: " title
            read -p "Body: " body
            read -p "Labels (bug/feature): " labels
            gh_create_issue "$title" "$body" "$labels"
            ;;
        2)
            read -p "Issue number: " issue
            gh_close_issue "$issue"
            ;;
        3)
            read -p "State (open/closed): " state
            gh_list_issues "${state:-open}"
            ;;
        4)
            read -p "Title: " title
            read -p "Body: " body
            gh_create_pr "$title" "$body"
            ;;
        5)
            read -p "PR number: " pr
            read -p "Method (squash/merge/rebase): " method
            gh_merge_pr "$pr" "$method"
            ;;
        6)
            read -p "PR number: " pr
            read -p "Verdict (approve/request-changes): " verdict
            read -p "Comment: " comment
            gh_review_pr "$pr" "$verdict" "$comment"
            ;;
        7)
            read -p "State (open/closed): " state
            gh_list_prs "${state:-open}"
            ;;
        8)
            read -p "Tag: " tag
            read -p "Title: " title
            read -p "Notes: " notes
            gh_create_release "$tag" "$title" "$notes"
            ;;
        9) gh_list_releases ;;
        0) show_main_menu ;;
        *) echo "Invalid option"; show_github_menu ;;
    esac
    
    show_github_menu
}

show_workflow_menu() {
    print_header "Workflow Operations"
    
    echo -e "${CYAN}1.${NC} List Workflows"
    echo -e "${CYAN}2.${NC} Trigger Workflow"
    echo -e "${CYAN}3.${NC} Watch Workflow"
    echo -e "${CYAN}4.${NC} List Workflow Runs"
    echo -e "${CYAN}0.${NC} Back"
    echo ""
    read -p "Select an option: " choice
    
    case $choice in
        1) gh_list_workflows ;;
        2)
            read -p "Workflow name: " workflow
            gh_trigger_workflow "$workflow"
            ;;
        3)
            read -p "Run ID: " run_id
            gh_watch_workflow "$run_id"
            ;;
        4)
            read -p "Workflow name: " workflow
            gh_list_workflow_runs "$workflow"
            ;;
        0) show_main_menu ;;
        *) echo "Invalid option"; show_workflow_menu ;;
    esac
    
    show_workflow_menu
}

show_automation_menu() {
    print_header "Automation"
    
    echo -e "${CYAN}1.${NC} Auto-assign PR"
    echo -e "${CYAN}2.${NC} Auto-label PR"
    echo -e "${CYAN}3.${NC} Close Stale Issues"
    echo -e "${CYAN}4.${NC} Generate Release Notes"
    echo -e "${CYAN}0.${NC} Back"
    echo ""
    read -p "Select an option: " choice
    
    case $choice in
        1)
            read -p "PR number: " pr
            gh_auto_assign "$pr"
            ;;
        2)
            read -p "PR number: " pr
            gh_auto_label "$pr"
            ;;
        3)
            read -p "Days before stale (default 30): " days
            gh_close_stale "${days:-30}"
            ;;
        4)
            read -p "Tag: " tag
            gh_release_notes "$tag"
            ;;
        0) show_main_menu ;;
        *) echo "Invalid option"; show_automation_menu ;;
    esac
    
    show_automation_menu
}

show_utility_menu() {
    print_header "Utilities"
    
    echo -e "${CYAN}1.${NC} Find Large Files"
    echo -e "${CYAN}2.${NC} Check Repo Size"
    echo -e "${CYAN}3.${NC} Setup Git Aliases"
    echo -e "${CYAN}0.${NC} Back"
    echo ""
    read -p "Select an option: " choice
    
    case $choice in
        1)
            read -p "Size in bytes (default 1MB): " size
            git_find_large "${size:-1048576}"
            ;;
        2) git_repo_size ;;
        3) git_setup_aliases ;;
        0) show_main_menu ;;
        *) echo "Invalid option"; show_utility_menu ;;
    esac
    
    show_utility_menu
}

show_setup_menu() {
    print_header "Setup"
    
    echo -e "${CYAN}1.${NC} Setup Git Aliases"
    echo -e "${CYAN}2.${NC} Configure Git"
    echo -e "${CYAN}0.${NC} Back"
    echo ""
    read -p "Select an option: " choice
    
    case $choice in
        1) git_setup_aliases ;;
        2)
            read -p "Git username: " username
            read -p "Git email: " email
            git config --global user.name "$username"
            git config --global user.email "$email"
            print_success "Git configured"
            ;;
        0) show_main_menu ;;
        *) echo "Invalid option"; show_setup_menu ;;
    esac
    
    show_setup_menu
}

# ============================================================
# Main Entry Point
# ============================================================

# Check if running with command
if [ $# -gt 0 ]; then
    command=$1
    shift
    
    case $command in
        quick-commit) git_quick_commit "$@" ;;
        feature) git_feature "$@" ;;
        hotfix) git_hotfix "$@" ;;
        status) git_smart_status ;;
        diff-stats) git_diff_stats "$@" ;;
        squash) git_squash "$@" ;;
        undo) git_undo ;;
        clean) git_clean_all ;;
        issue) gh_create_issue "$@" ;;
        pr) gh_create_pr "$@" ;;
        release) gh_create_release "$@" ;;
        workflows) gh_list_workflows ;;
        large) git_find_large "$@" ;;
        size) git_repo_size ;;
        aliases) git_setup_aliases ;;
        *)
            echo "Usage: $0 <command> [args]"
            echo ""
            echo "Commands:"
            echo "  quick-commit <type> [scope] <message>  - Quick commit"
            echo "  feature <name>                         - Create feature branch"
            echo "  hotfix <name>                          - Create hotfix branch"
            echo "  status                                  - Smart status"
            echo "  squash [count]                         - Squash commits"
            echo "  undo                                    - Undo last commit"
            echo "  clean                                   - Clean working dir"
            echo "  issue <title> <body> [labels]          - Create issue"
            echo "  pr <title> <body> [base]               - Create PR"
            echo "  release <tag> <title> <notes>          - Create release"
            echo "  workflows                               - List workflows"
            echo "  large [size]                            - Find large files"
            echo "  size                                    - Check repo size"
            echo "  aliases                                 - Setup aliases"
            echo ""
            echo "Or run without arguments for interactive menu."
            exit 1
            ;;
    esac
else
    show_main_menu
fi
