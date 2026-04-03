# Skill Auto-Suggest Protocol

When the user asks a question, scan the topic against available skills. If a match is found:

1. Proactively tell the user which skill is relevant (in Chinese)
2. Read and follow that skill's SKILL.md file immediately
3. Format: "检测到这个问题涉及 [技能名]，已自动加载相关专业知识。"

## Skill Discovery

Before answering domain-specific questions:
1. Check project-level skills directory for relevant skills
2. Use the most specific matching skill

## Important Rules

- Only suggest skills that are genuinely relevant
- If multiple skills match, pick the most specific one
- If no skill matches, answer normally using base rules
- The suggestion line should be brief
