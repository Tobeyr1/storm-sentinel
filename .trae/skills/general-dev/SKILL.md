---
name: general-dev
description: >-
  General software development best practices, design patterns, and architecture
  guidance. Use for questions about clean code, SOLID principles, design patterns,
  refactoring strategies, or general software engineering decisions.
---

# General Development Best Practices

## When to Use This Skill

Activate when the user asks about:
- Clean code principles, code organization
- Design patterns (Factory, Strategy, Observer, etc.)
- SOLID principles, DRY, KISS, YAGNI
- Refactoring strategies
- Architecture decisions (monolith vs microservices, layered vs hexagonal)
- API design (REST, GraphQL, gRPC)
- Error handling strategies
- Testing strategies (unit, integration, e2e)

## Core Principles

### Code Organization
- One responsibility per function/class/module
- Group by feature, not by type (prefer feature folders over type folders)
- Keep public APIs small and focused
- Depend on abstractions, not concretions

### Error Handling
- Fail fast, fail loudly in development
- Graceful degradation in production
- Never swallow errors silently
- Use typed errors over generic exceptions where the language supports it

### Testing Strategy
- Unit tests for business logic (fast, isolated)
- Integration tests for boundaries (DB, API, file system)
- E2E tests for critical user flows (few, focused)
- Test behavior, not implementation

### API Design
- Consistent naming and structure
- Proper HTTP status codes for REST
- Pagination for list endpoints
- Versioning strategy from day one

## Reference Catalog

For deeper guidance on specific topics, see the `references/` directory:

| Topic | File |
|-------|------|
| Design Patterns | `references/design-patterns.md` |
| Clean Architecture | `references/clean-architecture.md` |
| Testing Guide | `references/testing-guide.md` |
