#!/bin/bash
# Daily Git Workflow Script
# A complete daily workflow script for developers

echo "=== Daily Git Workflow ==="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function: Morning routine
morning_routine() {
    echo -e "${BLUE}=== Morning Routine ===${NC}"
    echo ""
    
    # Fetch latest changes
    echo -e "${YELLOW}Fetching latest changes...${NC}"
    git fetch --all --prune
    echo ""
    
    # Switch to main and pull
    echo -e "${YELLOW}Switching to main and pulling...${NC}"
    git checkout main
    git pull origin main
    echo ""
    
    # Show status
    echo -e "${YELLOW}Current status:${NC}"
    echo "Branch: $(git branch --show-current)"
    echo "Last commit: $(git log -1 --pretty=format:'%h - %s')"
    echo ""
    
    # Show any stashes
    STASH_COUNT=$(git stash list | wc -l)
    if [ $STASH_COUNT -gt 0 ]; then
        echo -e "${YELLOW}You have $STASH_COUNT stash(es):${NC}"
        git stash list
        echo ""
    fi
}

# Function: Start a feature
start_feature() {
    if [ -z "$1" ]; then
        echo -e "${RED}Error: Please provide a feature name${NC}"
        echo "Usage: start-feature <feature-name>"
        return 1
    fi
    
    echo -e "${BLUE}=== Starting Feature: $1 ===${NC}"
    echo ""
    
    # Make sure we're on main
    git checkout main
    git pull origin main
    
    # Create and switch to feature branch
    git checkout -b "feature/$1"
    echo ""
    echo -e "${GREEN}Created and switched to feature/$1${NC}"
    echo ""
}

# Function: Work on feature
work_on_feature() {
    BRANCH=$(git branch --show-current)
    
    if [[ ! $BRANCH == feature/* ]]; then
        echo -e "${RED}Error: Not on a feature branch${NC}"
        return 1
    fi
    
    echo -e "${BLUE}=== Working on: $BRANCH ===${NC}"
    echo ""
    
    # Show what's changed
    echo -e "${YELLOW}Changes since last commit:${NC}"
    git status -s
    echo ""
    
    # Show diff if there are changes
    if [ -n "$(git status --porcelain)" ]; then
        echo -e "${YELLOW}Detailed diff:${NC}"
        git diff --stat
        echo ""
    fi
}

# Function: Save progress (commit)
save_progress() {
    if [ -z "$1" ]; then
        echo -e "${RED}Error: Please provide a commit message${NC}"
        echo "Usage: save-progress <message>"
        return 1
    fi
    
    echo -e "${BLUE}=== Saving Progress ===${NC}"
    echo ""
    
    # Stage all changes
    git add -A
    
    # Show what's staged
    echo -e "${YELLOW}Staged files:${NC}"
    git status -s
    echo ""
    
    # Commit
    git commit -m "$1"
    echo ""
    echo -e "${GREEN}Changes saved!${NC}"
    echo ""
}

# Function: Push to remote
push_changes() {
    BRANCH=$(git branch --show-current)
    
    echo -e "${BLUE}=== Pushing Changes ===${NC}"
    echo ""
    
    # Push to remote
    git push origin "$BRANCH"
    echo ""
    echo -e "${GREEN}Changes pushed to origin/$BRANCH${NC}"
    echo ""
}

# Function: Create PR
create_pr() {
    BRANCH=$(git branch --show-current)
    
    if [[ ! $BRANCH == feature/* ]]; then
        echo -e "${RED}Error: Not on a feature branch${NC}"
        return 1
    fi
    
    echo -e "${BLUE}=== Creating Pull Request ===${NC}"
    echo ""
    
    # Push first
    git push origin "$BRANCH"
    
    # Create PR using GitHub CLI
    if command -v gh &> /dev/null; then
        gh pr create \
            --title "$(echo $BRANCH | sed 's/feature\///' | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')" \
            --body "## Description\n\n## Changes\n\n## Testing"
        echo ""
        echo -e "${GREEN}Pull request created!${NC}"
    else
        echo -e "${YELLOW}GitHub CLI not found. Please create PR manually.${NC}"
        echo "Branch: $BRANCH"
    fi
    echo ""
}

# Function: Finish feature
finish_feature() {
    BRANCH=$(git branch --show-current)
    
    if [[ ! $BRANCH == feature/* ]]; then
        echo -e "${RED}Error: Not on a feature branch${NC}"
        return 1
    fi
    
    echo -e "${BLUE}=== Finishing Feature: $BRANCH ===${NC}"
    echo ""
    
    # Switch to main
    git checkout main
    git pull origin main
    
    # Merge feature
    echo -e "${YELLOW}Merging $BRANCH into main...${NC}"
    git merge "$BRANCH"
    echo ""
    
    # Push to remote
    echo -e "${YELLOW}Pushing to remote...${NC}"
    git push origin main
    echo ""
    
    # Delete local branch
    echo -e "${YELLOW}Deleting local branch...${NC}"
    git branch -d "$BRANCH"
    echo ""
    
    echo -e "${GREEN}Feature complete!${NC}"
    echo ""
}

# Function: End of day
end_of_day() {
    echo -e "${BLUE}=== End of Day Summary ===${NC}"
    echo ""
    
    # Show today's commits
    echo -e "${YELLOW}Today's commits:${NC}"
    git log --oneline --since="midnight"
    echo ""
    
    # Check for uncommitted changes
    if [ -n "$(git status --porcelain)" ]; then
        echo -e "${YELLOW}You have uncommitted changes:${NC}"
        git status -s
        echo ""
        echo "Consider stashing or committing before you go!"
    else
        echo -e "${GREEN}Working directory is clean!${NC}"
    fi
    echo ""
    
    # Show branch status
    echo -e "${YELLOW}Branch status:${NC}"
    git branch -v
    echo ""
}

# Function: Show help
show_help() {
    echo -e "${GREEN}Daily Git Workflow Commands:${NC}"
    echo ""
    echo "  morning-routine       Start your day (fetch, pull, status)"
    echo "  start-feature <name>  Start a new feature branch"
    echo "  work-on-feature       Show current work status"
    echo "  save-progress <msg>   Commit your changes"
    echo "  push-changes          Push to remote"
    echo "  create-pr             Create a pull request"
    echo "  finish-feature        Merge feature to main"
    echo "  end-of-day            Show daily summary"
    echo ""
}

# Main script
case "$1" in
    morning-routine)
        morning_routine
        ;;
    start-feature)
        start_feature "$2"
        ;;
    work-on-feature)
        work_on_feature
        ;;
    save-progress)
        save_progress "$2"
        ;;
    push-changes)
        push_changes
        ;;
    create-pr)
        create_pr
        ;;
    finish-feature)
        finish_feature
        ;;
    end-of-day)
        end_of_day
        ;;
    *)
        show_help
        ;;
esac
