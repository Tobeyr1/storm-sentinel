# Git Workflow Conventions

## Commit Message Format

```
<type>(<scope>): <subject>

<body>
```

### Types
- feat: New feature
- fix: Bug fix
- refactor: Code refactoring (no functional change)
- perf: Performance improvement
- style: Code style / formatting
- docs: Documentation
- test: Adding or updating tests
- chore: Build, CI, tooling changes

### Scopes
Use the module, package, or feature area name. Examples: auth, api, ui, db, config, build, nav, core

### Examples
```
feat(auth): add OAuth2 login with Google provider
fix(api): handle token refresh race condition
refactor(ui): extract reusable LoadingErrorContent component
```

## Branch Naming
- feature/<ticket-id>-<brief-description>
- fix/<ticket-id>-<brief-description>
- refactor/<description>

## Pre-Commit Review
- No sensitive data (keys, tokens, passwords) in the diff
- No debug-only code (console.log, print, hardcoded test URLs)
- No TODO comments without ticket references
