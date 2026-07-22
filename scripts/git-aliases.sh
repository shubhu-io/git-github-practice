#!/bin/bash
# Git Aliases Setup Script
# Run this script to configure useful Git aliases

echo "=== Setting up Git Aliases ==="
echo ""

# Status aliases
git config --global alias.st status
git config --global alias.s status
echo "Added: git st / git s -> git status"

# Branch aliases
git config --global alias.br branch
git config --global alias.b branch
echo "Added: git br / git b -> git branch"

# Checkout aliases
git config --global alias.co checkout
git config --global alias.sw switch
echo "Added: git co -> git checkout, git sw -> git switch"

# Commit aliases
git config --global alias.cm commit
git config --global alias.ci commit
echo "Added: git cm / git ci -> git commit"

# Add aliases
git config --global alias.aa "add --all"
git config --global alias.ap "add -p"
echo "Added: git aa -> git add --all, git ap -> git add -p"

# Diff aliases
git config --global alias.df diff
git config --global alias.dfc "diff --cached"
git config --global alias.dfw "diff --word-diff"
echo "Added: git df -> git diff, git dfc -> git diff --cached"

# Log aliases
git config --global alias.lg "log --oneline --graph --all --decorate"
git config --global alias.lg2 "log --oneline --graph --decorate"
git config --global alias.ls "log --oneline -10"
git config --global alias.ll "log --pretty=format:'%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate --numstat"
echo "Added: git lg, git lg2, git ls, git ll -> log variations"

# Pull aliases
git config --global alias.pull "pull --rebase"
echo "Added: git pull -> git pull --rebase"

# Push aliases
git config --global alias.ps push
git config --global alias.psf "push --force-with-lease"
echo "Added: git ps -> git push, git psf -> git push --force-with-lease"

# Stash aliases
git config --global alias.stp stash pop
git config --global alias.stl stash list
git config --global alias.sta "stash apply"
echo "Added: git stp -> stash pop, git stl -> stash list"

# Cleanup aliases
git config --global alias.cleanup "!git branch --merged | grep -v '\\*\\|main\\|master' | xargs -n 1 git branch -d"
echo "Added: git cleanup -> delete merged branches"

# Undo aliases
git config --global alias.undo "reset HEAD~1 --soft"
git config --global alias.undo-hard "reset --hard HEAD~1"
echo "Added: git undo -> soft reset, git undo-hard -> hard reset"

# Show aliases
git config --global alias.last "log -1 HEAD"
git config --global alias.tags "tag -l"
echo "Added: git last -> last commit, git tags -> list tags"

# Remote aliases
git config --global alias.remotes "remote -v"
git config --global alias.fetch "fetch --all --prune"
echo "Added: git remotes -> remote -v, git fetch -> fetch --all"

# Quick add and commit
git config --global alias.ac '!git add -A && git commit -m'
echo "Added: git ac 'message' -> git add -A && git commit"

# Amend last commit
git config --global alias.amend "commit --amend --no-edit"
echo "Added: git amend -> commit --amend --no-edit"

# View config
git config --global alias.configs "!git config --global --list | grep alias"
echo "Added: git configs -> list all aliases"

echo ""
echo "=== Alias Setup Complete ==="
echo ""
echo "To see all aliases, run: git configs"
echo "To undo all aliases, run: git config --global --remove-section alias"
echo ""
