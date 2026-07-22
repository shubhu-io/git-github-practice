# Git Security Best Practices

Keep your code and repositories secure.

## Security Checklist

- [ ] Never commit secrets or credentials
- [ ] Use SSH keys for authentication
- [ ] Enable 2FA on GitHub
- [ ] Use branch protection rules
- [ ] Scan for vulnerabilities
- [ ] Audit dependencies regularly
- [ ] Use signed commits
- [ ] Review code before merging

## Never Commit Secrets

### .gitignore for Secrets

```gitignore
# Environment files
.env
.env.local
.env.*.local

# Credentials
*.pem
*.key
*.cert
credentials.json
service-account.json

# API Keys
apiKey.txt
secrets.yml

# Config files with secrets
config.json
config.yml
```

### Check for Secrets Before Commit

```bash
# Search for potential secrets
git diff --cached | grep -i "password\|secret\|key\|token"

# Use git-secrets (install first)
git secrets --install
git secrets --register-aws
git secrets --scan
```

### Remove Secrets from History

```bash
# If you accidentally committed secrets
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch .env" \
  --prune-empty --tag-name-filter cat -- --all

# Force push (DANGEROUS - coordinate with team)
git push origin main --force

# Consider rotating all compromised credentials
```

## SSH Authentication

### Generate SSH Key

```bash
# Generate new key
ssh-keygen -t ed25519 -C "your@email.com"

# Or RSA
ssh-keygen -t rsa -b 4096 -C "your@email.com"
```

### Add to SSH Agent

```bash
# Start agent
eval "$(ssh-agent -s)"

# Add key
ssh-add ~/.ssh/id_ed25519

# Copy public key to clipboard (macOS)
pbcopy < ~/.ssh/id_ed25519.pub

# Copy public key to clipboard (Linux)
xclip -selection clipboard < ~/.ssh/id_ed25519.pub
```

### Use SSH for Git

```bash
# Change remote to SSH
git remote set-url origin git@github.com:user/repo.git

# Test connection
ssh -T git@github.com
```

## Branch Protection Rules

### Set Up on GitHub

1. Go to **Settings** > **Branches**
2. Add rule for `main` branch:
   - ✅ Require pull request before merging
   - ✅ Require approvals
   - ✅ Require status checks to pass
   - ✅ Require branches to be up to date
   - ✅ Require conversation resolution
   - ✅ Include administrators

### Set Up via CLI

```bash
# Install GitHub CLI
brew install gh

# Login
gh auth login

# Set branch protection
gh api repos/{owner}/{repo}/branches/main/protection -X PUT -f '{
  "required_status_checks": {
    "strict": true,
    "contexts": ["ci/build", "ci/test"]
  },
  "required_pull_request_reviews": {
    "required_approving_review_count": 1
  },
  "enforce_admins": true,
  "restrictions": null
}'
```

## Signed Commits

### Set Up GPG Signing

```bash
# Generate GPG key
gpg --full-generate-key

# List keys
gpg --list-secret-keys --keyid-format=long

# Export public key
gpg --armor --export YOUR_KEY_ID

# Add to GitHub
# Settings > SSH and GPG keys > New GPG key
```

### Configure Git

```bash
# Set signing key
git config --global user.signingkey YOUR_KEY_ID

# Enable signing
git config --global commit.gpgsign true

# Set GPG program (if needed)
git config --global gpg.program gpg
```

### Sign Commits

```bash
# Sign commits automatically
git config --global commit.gpgsign true

# Or sign specific commits
git commit -S -m "Signed commit"
```

## GitHub Security Features

### Enable Security Alerts

1. Go to **Settings** > **Code security and analysis**
2. Enable:
   - Dependency graph
   - Dependabot alerts
   - Dependabot security updates
   - Secret scanning

### Enable Secret Scanning

```bash
# Push protection (blocks secrets from being pushed)
gh api repos/{owner}/{repo}/secret-scanning/push-protection -X PUT
```

## Secure Git Configuration

### Add to ~/.gitconfig

```ini
[core]
    # Don't follow symlinks outside repo
    symlinks = false
    
    # Trust file system case
    ignoreCase = false

[receive]
    # Reject non-signed commits (optional)
    denyNonFastForwards = true
    denyDeletes = true

[pull]
    # Don't allow rebasing (safer)
    rebase = false
```

## Dependency Security

### Use npm audit

```bash
# Check for vulnerabilities
npm audit

# Fix vulnerabilities
npm audit fix

# Fix with breaking changes
npm audit fix --force
```

### Use Snyk

```bash
# Install Snyk
npm install -g snyk

# Test for vulnerabilities
snyk test

# Monitor project
snyk monitor
```

### Dependabot Configuration

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
      day: "monday"
    open-pull-requests-limit: 10
    labels:
      - "dependencies"
      - "security"
```

## Code Scanning

### GitHub Code Scanning

```yaml
# .github/workflows/codeql.yml
name: CodeQL

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 6 * * 1'

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: github/codeql-action/init@v3
        with:
          languages: javascript
      - uses: github/codeql-action/autobuild@v3
      - uses: github/codeql-action/analyze@v3
```

## Best Practices

### For Developers

1. **Never commit secrets** - Use environment variables
2. **Use SSH keys** - More secure than passwords
3. **Enable 2FA** - On GitHub and SSH
4. **Sign commits** - Verify authorship
5. **Review code** - Before merging
6. **Keep dependencies updated** - Patch vulnerabilities

### For Teams

1. **Use branch protection** - Prevent direct pushes
2. **Require reviews** - At least one approval
3. **Enable security features** - Dependabot, CodeQL
4. **Audit access** - Regular permission reviews
5. **Document secrets** - Where they are stored
6. **Rotate credentials** - Regularly

### For Organizations

1. **Enforce policies** - Organization-wide
2. **Use SSO** - Single sign-on
3. **Audit logs** - Monitor activity
4. **Security training** - Educate team
5. **Incident response** - Have a plan

## Resources

- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [Git Security](https://git-scm.com/book/en/v2/Git-Tools-Security)
- [OWASP Security](https://owasp.org/)
