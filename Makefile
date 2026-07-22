# Makefile for Git & GitHub Practice Repository

.PHONY: help install test lint format build clean dev

# Default target
help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Development
install: ## Install dependencies
	npm install

dev: ## Start development server
	npm run dev

# Testing
test: ## Run tests
	npm test

test-watch: ## Run tests in watch mode
	npm run test:watch

test-coverage: ## Run tests with coverage
	npm run test:coverage

# Code Quality
lint: ## Run linter
	npm run lint

lint-fix: ## Fix linting issues
	npm run lint:fix

format: ## Format code with Prettier
	npm run format

format-check: ## Check formatting
	npm run format:check

validate: ## Run lint and tests
	npm run validate

# Build
build: ## Build the project
	npm run build

# Clean
clean: ## Clean node_modules and build artifacts
	rm -rf node_modules dist build coverage
	npm cache clean --force

# Git Operations
git-setup: ## Setup Git configuration
	./scripts/setup.sh

git-aliases: ## Setup Git aliases
	bash scripts/git-aliases.sh

git-helpers: ## Source Git helper functions
	source scripts/git-helpers.sh

# Docker
docker-build: ## Build Docker image
	docker build -t git-github-practice .

docker-run: ## Run Docker container
	docker-compose up -d

docker-stop: ## Stop Docker containers
	docker-compose down

docker-clean: ## Clean Docker resources
	docker-compose down -v
	docker system prune -f

# Examples
example-branching: ## Run branching example
	bash examples/branching.sh

example-merge: ## Run merge conflict example
	bash examples/merge-conflict.sh

example-stash: ## Run stash example
	bash examples/stash-practice.sh

example-rebase: ## Run rebase example
	bash examples/rebase-practice.sh

example-undo: ## Run undo example
	bash examples/undo-practice.sh

example-cherry-pick: ## Run cherry-pick example
	bash examples/cherry-pick.sh

example-tagging: ## Run tagging example
	bash examples/tagging.sh

example-bisect: ## Run bisect example
	bash examples/bisect.sh

# Exercises
exercise-1: ## Run exercise 1 (First Commit)
	@echo "Complete the exercise in exercises/01-first-commit/"

exercise-2: ## Run exercise 2 (Branching)
	@echo "Complete the exercise in exercises/02-branching/"

exercise-3: ## Run exercise 3 (Merge Conflicts)
	@echo "Complete the exercise in exercises/03-merge-conflicts/"

# Documentation
docs-serve: ## Serve documentation locally
	@echo "Open docs/ directory in your browser"

# GitHub
github-pr: ## Create a pull request
	gh pr create

github-pr-list: ## List pull requests
	gh pr list

github-issue-list: ## List issues
	gh issue list

# Utilities
check-deps: ## Check for outdated dependencies
	npm outdated

update-deps: ## Update dependencies
	npm update

security-audit: ## Run security audit
	npm audit

# Info
info: ## Show project information
	@echo "Project: Git & GitHub Practice"
	@echo "Version: $(shell node -p "require('./package.json').version")"
	@echo "Node: $(shell node --version)"
	@echo "NPM: $(shell npm --version)"
