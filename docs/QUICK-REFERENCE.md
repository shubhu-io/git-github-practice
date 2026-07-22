---
layout: default
title: Quick Reference
nav_order: 5
---
# Git Quick Reference Card

## SETUP
  git config --global user.name "Name"
  git config --global user.email "email"

## START
  git init                           # New repo
  git clone <url>                    # Copy existing repo

## DAILY WORKFLOW
  git status                         # What's changed?
  git add .                          # Stage everything
  git commit -m "message"            # Save changes
  git push                           # Upload to GitHub
  git pull                           # Download from GitHub

## BRANCHES
  git branch                         # List branches
  git checkout -b <name>             # New branch + switch
  git switch <name>                  # Switch branch
  git merge <branch>                 # Merge branch in
  git branch -d <name>               # Delete branch

## UNDO
  git restore <file>                 # Discard file changes
  git restore --staged <file>        # Unstage file
  git reset HEAD~1                   # Undo last commit
  git revert <commit>                # Safe undo (pushed)

## STASH
  git stash                          # Save work temporarily
  git stash pop                      # Get it back

## REMOTE
  git remote add origin <url>        # Connect remote
  git push -u origin <branch>        # Push + set upstream
  git fetch                          # Download only

## LOGS
  git log --oneline                  # Quick history
  git log --oneline --graph          # Visual history
  git diff                           # See changes

## TAGS
  git tag v1.0.0                     # Create tag
  git push origin --tags             # Push tags

## GITHUB CLI
  gh repo create                     # New repo
  gh pr create                       # New PR
  gh issue create                    # New issue
  gh pr list                         # List PRs
