---
layout: single
title: "Profiles & Organizations"
---

# Profiles & Organizations

## GitHub Profile

### Profile README

Create a repo named `<username>/<username>` (e.g., `shubhu-io/shubhu-io`).
The `README.md` appears on your profile.

```markdown
# Hi, I'm Shubhu 👋

- 🔭 I'm currently working on Git & GitHub
- 🌱 I'm learning DevOps
- 💬 Ask me about Git
- 📫 Reach me: [email](mailto:email@example.com)

## Skills
![JavaScript](https://img.shields.io/badge/-JavaScript-F7DF1E?logo=javascript)
![Git](https://img.shields.io/badge/-Git-F05032?logo=git)

## Stats
![GitHub stats](https://github-readme-stats.vercel.app/api?username=shubhu-io&show_icons=true)
```

### Profile Features

| Feature | How-to |
|---|---|
| Badges | Shields.io: `![Label](https://img.shields.io/badge/Label-COLOR?logo=name)` |
| Stats cards | `github-readme-stats.vercel.app/api?username=USER` |
| Top languages | `github-readme-stats.vercel.app/api/top-langs?username=USER` |
| Activity graph | `github-readme-activity-graph.vercel.app/graph?username=USER` |
| Visitor counter | `https://visitcount.itsvg.in/api?id=USER&icon=0` |
| Pinned repos | Set in GitHub profile settings |
| Achievements | Automatic based on activity |
| Contribution grid | Top section of profile |

### Profile Settings

```
Settings → Profile
  - Name
  - Bio
  - Company
  - Location
  - Website URL
  - Pronouns
  - Social accounts
  - Email visibility
```

## Organizations

### Creating an Org

```
https://github.com/organizations/plan
  - Free: Unlimited public/private repos
  - Team: Advanced collaboration
  - Enterprise: SAML, audit, compliance
```

### Organization Features

| Feature | Location |
|---|---|
| People | `https://github.com/orgs/<org>/people` |
| Teams | `https://github.com/orgs/<org>/teams` |
| Projects | `https://github.com/orgs/<org>/projects` |
| Settings | `https://github.com/organizations/<org>/settings` |
| Audit log | `https://github.com/organizations/<org>/settings/audit-log` |
| Security | `https://github.com/organizations/<org>/settings/security` |

### Teams

```bash
gh api orgs/:org/teams -X POST \
  -f name=developers \
  -f description="Core dev team" \
  -f privacy=closed

gh api orgs/:org/teams/developers/memberships/:username -X PUT \
  -f role=member
```

### Organization Roles

| Role | Permissions |
|---|---|
| Owner | Full admin access |
| Member | Standard access |
| Billing manager | Billing settings |
| Moderator | Comment moderation, reports |
| Outside collaborator | Limited repo access |

## Repository Visibility

| Visibility | Who can see | Use case |
|---|---|---|
| Public | Everyone | Open source |
| Private | You + invited collaborators | Proprietary work |
| Internal | All org members | Internal tools |

## GitHub Sponsors

Enable sponsors via:
```
https://github.com/sponsors
  - Individual: Personal sponsorships
  - Organization: Org sponsorships
  - One-time or monthly tiers
```
