# Skill Auto-Suggest Protocol

When the user asks a question, scan the topic against available skills. If a match is found:

1. Proactively tell the user which skill is relevant (in Chinese)
2. Read and follow that skill's SKILL.md file immediately
3. Format: "检测到这个问题涉及 [技能名]，已自动加载相关专业知识。"

## Android/Kotlin Skill Routing

When the user's question involves Android or Kotlin topics, the following rules auto-activate based on file context (`.kt` files):

| User Topic Keywords | Auto-Active Rule |
|---------------------|-----------------|
| Compose UI, Composable, recomposition | `compose-ui` rule |
| ViewModel, StateFlow, UiState | `architecture-mvvm` rule |
| Coroutine, Flow, suspend | `android-kotlin` rule |
| Jetpack, Lifecycle, Navigation, Room | `kotlin-jetpack` rule |

These rules are file-scoped (`paths: ["**/*.kt"]`) and only activate for Kotlin files.

## Flutter/Dart Skill Routing

When the user's question involves Flutter or Dart topics, the following rules auto-activate based on file context (`.dart` files):

| User Topic Keywords | Auto-Active Rule |
|---------------------|-----------------|
| Widget, build method, StatelessWidget | `flutter-dart` rule |
| State management, ChangeNotifier, Provider, BLoC | `flutter-state-arch` rule |
| GoRouter, Navigation, routing | `flutter-dart` rule |
| Material 3, ThemeData, responsive | `flutter-dart` rule |
| Feature structure, MVVM, Repository, DI | `flutter-state-arch` rule |
| Testing, widget test, integration test | `flutter-dart` rule |

These rules are file-scoped (`paths: ["**/*.dart"]`) and only activate for Dart files. The Dart MCP server provides additional AI tooling.

When using the **Flutter development skill**, read `.trae/skills/flutter-dev/SKILL.md` for comprehensive patterns and references.

## Fix Lint & Formatting Skill

When the user mentions any of these keywords, auto-load the `fix-lint` skill:

| Trigger Keywords | Action |
|-----------------|--------|
| lint, format, prettier, eslint, CI failed | Load `fix-lint` skill |
| dart analyze, dart format, ktlint, ruff, clippy | Load `fix-lint` skill |
| "提交前检查", "格式化", "代码规范" | Load `fix-lint` skill |

The skill auto-detects project type and runs the correct formatter/linter commands.

## Skill Discovery

Before answering domain-specific questions:
1. Check `.cursor/skills/` (Cursor) or `.trae/skills/` (Trae) for project-level skills
2. Check user-level global skills
3. Use the most specific matching skill

## Context7 — Real-time Documentation Lookup

When the user's question involves specific library API usage, version-specific behavior, or latest API changes, use Context7 MCP to fetch up-to-date documentation. Triggers:
- "这个 API 怎么用" / "最新的 XX 用法"
- Specific library APIs or framework features
- Version upgrades, migrations

## Important Rules

- Only suggest skills that are genuinely relevant
- If multiple skills match, pick the most specific one
- If no skill matches, answer normally using base rules
- The suggestion line should be brief
- Use Context7 for API-specific questions, use Skills for pattern/architecture questions
