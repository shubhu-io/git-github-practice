#!/bin/bash
# Git Workflow Script
# Common Git workflow commands

echo "=== Git Workflow Helper ==="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Function: Start new feature
start-feature() {
    if [ -z "$1" ]; then
        echo -e "${RED}Error: Please provide a feature name${NC}"
        echo "Usage: start-feature <feature-name>"
        return 1
    fi
    
    echo -e "${YELLOW}Starting new feature: $1${NC}"
    git checkout main
    git pull origin main
    git checkout -b "feature/$1"
    echo -e "${GREEN}Created and switched to feature/$1${NC}"
}

# Function: Finish feature
finish-feature() {
    BRANCH=$(git branch --show-current)
    if [[ ! $BRANCH == feature/* ]]; then
        echo -e "${RED}Error: Not on a feature branch${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}Finishing feature: $BRANCH${NC}"
    git checkout main
    git pull origin main
    git merge "$BRANCH"
    git push origin main
    git branch -d "$BRANCH"
    echo -e "${GREEN}Feature merged and deleted${NC}"
}

# Function: Start hotfix
start-hotfix() {
    if [ -z "$1" ]; then
        echo -e "${RED}Error: Please provide a hotfix name${NC}"
        echo "Usage: start-hotfix <hotfix-name>"
        return 1
    fi
    
    echo -e "${YELLOW}Starting hotfix: $1${NC}"
    git checkout main
    git checkout -b "hotfix/$1"
    echo -e "${GREEN}Created and switched to hotfix/$1${NC}"
}

# Function: Finish hotfix
finish-hotfix() {
    BRANCH=$(git branch --show-current)
    if [[ ! $BRANCH == hotfix/* ]]; then
        echo -e "${RED}Error: Not on a hotfix branch${NC}"
        return 1
    fi
    
    echo -e "${YELLOW}Finishing hotfix: $BRANCH${NC}"
    git checkout main
    git merge "$BRANCH"
    git push origin main
    git checkout develop
    git merge "$BRANCH"
    git push origin develop
    git branch -d "$BRANCH"
    echo -e "${GREEN}Hotfix merged to main and develop${NC}"
}

# Function: Quick commit
quick-commit() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo -e "${RED}Error: Please provide type and message${NC}"
        echo "Usage: quick-commit <type> <message>"
        echo "Types: feat, fix, docs, style, refactor, test, chore"
        return 1
    fi
    
    git add -A
    git commit -m "$1: $2"
    echo -e "${GREEN}Committed: $1: $2${NC}"
}

# Function: Sync with remote
sync-remote() {
    echo -e "${YELLOW}Syncing with remote...${NC}"
    git fetch origin
    git checkout main
    git pull origin main
    echo -e "${GREEN}Synced with origin/main${NC}"
}

# Function: Show status
show-status() {
    echo -e "${YELLOW}Repository Status:${NC}"
    echo ""
    echo "Branch: $(git branch --show-current)"
    echo "Status:"
    git status -s
    echo ""
    echo "Recent commits:"
    git log --oneline -5
}

# Function: Create release tag
create-release() {
    if [ -z "$1" ]; then
        echo -e "${RED}Error: Please provide a version${NC}"
        echo "Usage: create-release <version>"
        echo "Example: create-release 1.0.0"
        return 1
    fi
    
    echo -e "${YELLOW}Creating release v$1${NC}"
    git tag -a "v$1" -m "Release version $1"
    git push origin "v$1"
    echo -e "${GREEN}Release v$1 created and pushed${NC}"
}

# Function: Show help
show-help() {
    echo -e "${GREEN}Git Workflow Commands:${NC}"
    echo ""
    echo "  start-feature <name>    Start a new feature branch"
    echo "  finish-feature          Finish current feature"
    echo "  start-hotfix <name>     Start a hotfix branch"
    echo "  finish-hotfix           Finish current hotfix"
    echo "  quick-commit <type> <msg> Quick conventional commit"
    echo "  sync-remote             Sync with remote"
    echo "  show-status             Show repository status"
    echo "  create-release <ver>    Create release tag"
    echo ""
}

# Main script
case "$1" in
    start-feature)
        start-feature "$2"
        ;;
    finish-feature)
        finish-feature
        ;;
    start-hotfix)
        start-hotfix "$2"
        ;;
    finish-hotfix)
        finish-hotfix
        ;;
    quick-commit)
        quick-commit "$2" "$3"
        ;;
    sync-remote)
        sync-remote
        ;;
    show-status)
        show-status
        ;;
    create-release)
        create-release "$2"
        ;;
    *)
        show-help
        ;;
esac
