---
name: update-docs
description: >-
  Update documentation for Flutter projects. Automatically detects Flutter project structure and updates documentation files to reflect code changes.
---

# Update Documentation for Flutter Projects

Inspired by [vercel/next.js/.agents/skills/update-docs](https://github.com/vercel/next.js/tree/canary/.agents/skills/update-docs).

## Instructions

1. **Detect Flutter project structure** by checking for `pubspec.yaml`
2. **Identify documentation files** in the project
3. **Update documentation** to reflect code changes
4. **Ensure consistency** across documentation files

## Flutter Project Documentation Structure

### Common Documentation Files

| File | Purpose | Update Strategy |
|------|---------|----------------|
| `README.md` | Project overview | Update based on pubspec.yaml and project structure |
| `CHANGELOG.md` | Version history | Update with new features and fixes |
| `CONTRIBUTING.md` | Contribution guidelines | Ensure Flutter-specific instructions |
| `docs/` | Detailed documentation | Update API references and guides |
| `lib/` | Source code | Update inline comments and docstrings |

### Flutter-Specific Documentation

| File | Purpose | Update Strategy |
|------|---------|----------------|
| `pubspec.yaml` | Dependencies and metadata | Keep description and version up to date |
| `lib/main.dart` | Entry point | Update comments and documentation |
| `test/` | Test files | Update test documentation |
| `android/` | Android platform | Update platform-specific docs |
| `ios/` | iOS platform | Update platform-specific docs |

## Update Process

### 1. Analyze Project Structure

- Check `pubspec.yaml` for project name, version, and description
- Identify main features and modules in `lib/`
- Check for existing documentation files

### 2. Update README.md

- Ensure project description matches pubspec.yaml
- Update installation instructions for Flutter
- Add/Update usage examples
- Include platform-specific notes
- Update badges and links

### 3. Update CHANGELOG.md

- Follow semantic versioning
- Add entries for new features, bug fixes, and breaking changes
- Include version numbers and dates
- Reference related issues or PRs

### 4. Update Inline Documentation

- Update docstrings for public APIs
- Ensure consistent documentation style
- Add examples for complex functions
- Update parameter descriptions

### 5. Update Platform-Specific Documentation

- Android: Update `android/README.md` if present
- iOS: Update `ios/README.md` if present
- Include platform-specific requirements

## Flutter Documentation Best Practices

### Style Guide

- Use Markdown format
- Follow Dart documentation conventions
- Use consistent headings and formatting
- Include code examples with proper formatting

### Content Guidelines

- Be concise and clear
- Focus on user needs
- Include step-by-step instructions
- Provide troubleshooting tips
- Link to relevant Flutter documentation

### Automation Tips

- Use `dart doc` to generate API documentation
- Consider using documentation generators like `docusaurus` for large projects
- Set up CI to check documentation completeness

## Common Documentation Issues

- **Outdated examples** - Update to use current Flutter APIs
- **Missing platform notes** - Add iOS/Android specific information
- **Inconsistent versioning** - Ensure version numbers match across files
- **Broken links** - Check and update external links
- **Missing API documentation** - Add docstrings for public methods

## Recommended Workflow

```
1. Make code changes
2. Run `dart doc` to generate API documentation
3. Update README.md with new features
4. Add CHANGELOG.md entry
5. Review documentation for consistency
6. Commit changes
```