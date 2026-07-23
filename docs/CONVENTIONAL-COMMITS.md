---
layout: single
title: Conventional Commits
---
# Conventional Commits Guide

A specification for adding human and machine readable meaning to commit messages.

## The Conventional Commits Specification

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Types

| Type | Description | Example |
|------|-------------|---------|
| `feat` | A new feature | `feat: add user authentication` |
| `fix` | A bug fix | `fix: resolve login timeout` |
| `docs` | Documentation only changes | `docs: update API documentation` |
| `style` | Changes that don't affect meaning | `style: fix indentation` |
| `refactor` | Code change that neither fixes nor adds | `refactor: simplify auth logic` |
| `perf` | Performance improvement | `perf: optimize database queries` |
| `test` | Adding or correcting tests | `test: add unit tests for user service` |
| `build` | Build system or dependencies | `build: update webpack to v5` |
| `ci` | CI configuration changes | `ci: add GitHub Actions workflow` |
| `chore` | Other changes (no src/test) | `chore: update dependencies` |
| `revert` | Reverts a previous commit | `revert: undo changes from abc1234` |

## Scope

A scope may be provided after a type, to give contextual information about the changes:

```
feat(auth): add OAuth2 support
fix(api): handle null response
docs(readme): add installation instructions
```

## Description

- Use the imperative mood ("add" not "added")
- Don't capitalize the first letter
- No period at the end

## Examples

### Simple commit
```
feat: add user registration
```

### With scope
```
feat(auth): implement JWT token refresh
```

### With body
```
fix(auth): resolve token expiration issue

The previous implementation did not properly handle token refresh,
causing users to be logged out unexpectedly.

Closes #123
```

### With breaking change
```
feat(api)!: change authentication endpoint

BREAKING CHANGE: The /auth/login endpoint now requires OAuth2 instead of basic auth.

Migration guide:
- Update client to use OAuth2 flow
- Remove old basic auth code
```

## Footer

The footer should contain information about breaking changes and references to issues:

```
fix(auth): prevent duplicate login attempts

Previously, users could submit multiple login requests simultaneously,
causing race conditions.

Fixes #456
Ref: #789
```

## Tools

### commitlint

Enforce conventional commits with commitlint:

```bash
npm install --save-dev @commitlint/cli @commitlint/config-conventional
```

Create `commitlint.config.js`:
```javascript
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat', 'fix', 'docs', 'style', 'refactor',
        'perf', 'test', 'build', 'ci', 'chore', 'revert'
      ]
    ],
    'subject-full-stop': [2, 'never', '.'],
  },
};
```

### commitizen

Interactive commit creation:

```bash
npm install --save-dev commitizen cz-conventional-changelog
```

Add to `package.json`:
```json
{
  "config": {
    "commitizen": {
      "path": "cz-conventional-changelog"
    }
  }
}
```

Use with: `npx cz`

## Benefits

1. **Automated changelog generation**
2. **Semantic versioning automation**
3. **Better commit history readability**
4. **Easier to find changes**
5. **Tool support for release management**

## Links

- [Conventional Commits Official Site](https://www.conventionalcommits.org/)
- [Commitlint Documentation](https://commitlint.js.org/)
- [Commitizen Documentation](https://github.com/commitizen/cz-cli)
