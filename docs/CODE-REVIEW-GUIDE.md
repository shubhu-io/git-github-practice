---
layout: default
title: Code Review Guide
nav_order: 18
---
# Code Review Guide

Best practices for reviewing code on GitHub.

## Why Code Review Matters

- **Quality**: Catch bugs before they reach production
- **Knowledge Sharing**: Everyone learns from each other
- **Consistency**: Maintain coding standards
- **Security**: Identify potential vulnerabilities
- **Documentation**: Create a record of decisions

## Code Review Checklist

### Before Reviewing

- [ ] Understand the PR description and linked issues
- [ ] Check if CI/CD tests pass
- [ ] Review the diff (not the full file)
- [ ] Understand the context and requirements

### During Review

#### Functionality
- [ ] Does the code do what it's supposed to do?
- [ ] Are edge cases handled?
- [ ] Are error conditions handled properly?
- [ ] Is the logic correct?

#### Code Quality
- [ ] Is the code readable and understandable?
- [ ] Are functions/components appropriately sized?
- [ ] Is there code duplication that could be refactored?
- [ ] Are naming conventions consistent?

#### Security
- [ ] Are inputs validated and sanitized?
- [ ] Are there any SQL injection vulnerabilities?
- [ ] Are secrets/credentials properly handled?
- [ ] Are permissions checked appropriately?

#### Performance
- [ ] Are there unnecessary database queries?
- [ ] Are there memory leaks?
- [ ] Are there inefficient algorithms?
- [ ] Is caching used appropriately?

#### Testing
- [ ] Are there adequate tests?
- [ ] Do tests cover edge cases?
- [ ] Are tests readable and maintainable?
- [ ] Do tests actually test what they should?

#### Documentation
- [ ] Is the code well-commented?
- [ ] Are complex algorithms explained?
- [ ] Is the API documentation updated?
- [ ] Are there any README updates needed?

## How to Give Good Feedback

### Be Specific

**Bad:**
```
This is wrong.
```

**Good:**
```
This function doesn't handle the case where `user` is null.
Consider adding a null check before accessing `user.name`.
```

### Be Constructive

**Bad:**
```
This code is terrible.
```

**Good:**
```
Consider extracting this logic into a separate function
for better readability and reusability.
```

### Ask Questions

**Bad:**
```
Why did you do it this way?
```

**Good:**
```
I'm curious about the choice here. Was there a specific
reason you chose this approach over [alternative]?
```

### Use Code Suggestions

```suggestion
const result = data.filter(item => item.active);
```

## Types of Comments

### Required Changes (Must Fix)
```
[Must Fix] This will cause a runtime error when user is undefined.
```

### Suggestions (Nice to Have)
```
[Suggestion] Consider using const instead of let here
since the variable is never reassigned.
```

### Questions (Need Clarification)
```
[Question] What happens if the API returns a 500 error here?
```

### Praise (Positive Feedback)
```
[Praise] Great use of the strategy pattern here!
This makes the code very extensible.
```

### Nit (Minor Issues)
```
[Nit] Missing semicolon at end of line.
```

## Review Workflow

### For Reviewers

1. **First Pass**: Get an overview of the changes
2. **Second Pass**: Focus on details and logic
3. **Third Pass**: Check for edge cases and security
4. **Leave Comments**: Be specific and constructive
5. **Approve or Request Changes**: Be decisive

### For Authors

1. **Self-Review**: Review your own PR first
2. **Write Good Description**: Explain what and why
3. **Keep PRs Small**: Easier to review
4. **Respond to Feedback**: Be open to suggestions
5. **Make Changes**: Push fixes promptly

## Common Review Scenarios

### Large PR

```
This PR is quite large. Could you break it into smaller
PRs that can be reviewed independently? Consider:
1. PR for database changes
2. PR for API changes
3. PR for UI changes
```

### Missing Tests

```
This change adds new functionality but doesn't include tests.
Could you add unit tests for the new functions?
```

### Performance Concern

```
This loop makes an API call for each item. For large datasets,
this could be slow. Consider using Promise.all() or batching
the requests.
```

### Security Issue

```
[Must Fix] User input is being directly interpolated into
a SQL query. This is a SQL injection vulnerability.
Please use parameterized queries instead.
```

## GitHub Review Features

### Request Changes
```bash
gh pr review 123 --request-changes --body "Please fix..."
```

### Approve
```bash
gh pr review 123 --approve
```

### Comment
```bash
gh pr review 123 --comment --body "Looks good, just one question..."
```

## Best Practices

### For Reviewers

1. **Be timely** - Review within 24 hours
2. **Be respectful** - Assume good intent
3. **Be specific** - Provide actionable feedback
4. **Be humble** - You might learn something
5. **Use suggestions** - Makes it easy to apply fixes

### For Authors

1. **Self-review first** - Catch obvious issues
2. **Write clear descriptions** - Help reviewers understand
3. **Keep PRs small** - Under 400 lines is ideal
4. **Respond promptly** - Don't let PRs go stale
5. **Thank reviewers** - Appreciate their time

## Code Review Tools

### GitHub Built-in
- Request changes / Approve / Comment
- Suggestion blocks
- Code owners
- Branch protection rules

### Browser Extensions
- **Refined GitHub** - Better GitHub UI
- **Octotree** - File tree in PR view
- **GitLens** - VS Code integration

## Measuring Code Review

### Metrics to Track
- Time to first review
- Time to merge
- Number of review cycles
- Defects caught in review

### Goals
- First review within 24 hours
- Merge within 3 days
- Average 1-2 review cycles

## Resources

- [GitHub Code Review Guide](https://docs.github.com/en/pull-requests/reviewing-changes-in-pull-requests)
- [Google's Code Review Guidelines](https://google.github.io/eng-practices/review/)
- [Effective Code Reviews](https://www.freecodecamp.org/news/effective-code-reviews/)
