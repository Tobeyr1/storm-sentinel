---
name: fix-lint
description: >-
  Fix code formatting and lint errors before committing. Auto-detects project
  type (JS/TS, Flutter/Dart, Python, Kotlin/Android, Go, Rust, etc.) and runs
  the correct formatter and linter. Use when you have lint errors, formatting
  issues, or before committing code to ensure it passes CI.
---

# Fix Lint and Formatting

Inspired by [facebook/react/.claude/skills/fix](https://github.com/facebook/react/tree/main/.claude/skills/fix).

## Instructions

1. **Detect project type** by checking config files in the workspace root
2. **Run formatter** to auto-fix formatting issues
3. **Run linter** to check for remaining issues
4. **Report** any remaining manual fixes needed

## Project Detection & Commands

### JavaScript / TypeScript

| Signal File | Formatter | Linter |
|-------------|-----------|--------|
| `package.json` + `.prettierrc*` | `npx prettier --write .` | `npx eslint .` |
| `package.json` + `biome.json` | `npx biome format --write .` | `npx biome check .` |
| `deno.json` | `deno fmt` | `deno lint` |

**Priority**: Use project scripts first (`npm run format`, `npm run lint`) if defined in `package.json` scripts.

Check `package.json` scripts for common names:
- Format: `format`, `prettier`, `fmt`
- Lint: `lint`, `eslint`, `check`
- Combined: `fix`, `lint:fix`

### Flutter / Dart

| Signal File | Formatter | Linter |
|-------------|-----------|--------|
| `pubspec.yaml` | `dart format .` | `dart analyze .` |

Additional: `dart fix --apply` for auto-fixing lint issues.

If `build_runner` is in dependencies: `dart run build_runner build --delete-conflicting-outputs`

### Android / Kotlin

| Signal File | Formatter | Linter |
|-------------|-----------|--------|
| `build.gradle.kts` or `build.gradle` | `./gradlew ktlintFormat` | `./gradlew ktlintCheck` |
| `detekt.yml` | — | `./gradlew detekt` |

Fallback if ktlint not configured: `./gradlew lint` (Android Lint)

### Python

| Signal File | Formatter | Linter |
|-------------|-----------|--------|
| `pyproject.toml` (ruff) | `ruff format .` | `ruff check . --fix` |
| `pyproject.toml` (black) | `black .` | `ruff check .` or `flake8` |
| `setup.py` / `requirements.txt` | `black .` (if installed) | `flake8` (if installed) |

**Priority**: Prefer `ruff` (fast, all-in-one) over `black` + `flake8`.

### Go

| Signal File | Formatter | Linter |
|-------------|-----------|--------|
| `go.mod` | `gofmt -w .` or `goimports -w .` | `golangci-lint run` |

### Rust

| Signal File | Formatter | Linter |
|-------------|-----------|--------|
| `Cargo.toml` | `cargo fmt` | `cargo clippy --fix --allow-dirty` |

### Swift / iOS

| Signal File | Formatter | Linter |
|-------------|-----------|--------|
| `Package.swift` or `*.xcodeproj` | `swift-format format -r -i .` | `swiftlint` |

## Common Mistakes

- **Running formatter on wrong scope** — check if project scripts target only changed files vs all files
- **Ignoring linter errors** — these will fail CI; fix before committing
- **Not running build_runner** (Flutter) — generated files may be out of date after changes
- **Formatting before fixing** — run linter with `--fix` first, then format, to avoid conflicts
- **Skipping type check** — for TS projects, also run `tsc --noEmit` to catch type errors

## Recommended Workflow

```
1. Save all files
2. Run linter with auto-fix   (catches logic/style issues)
3. Run formatter               (normalizes formatting)
4. Run type checker if applicable (catches type errors)
5. Run tests if quick          (catches regressions)
6. Commit
```
