# Design Patterns Quick Reference

Practical patterns for everyday development. Not a textbook — focus on when and why to use each.

## Creational

| Pattern | When to Use | Avoid When |
|---------|-------------|------------|
| Factory Method | Object creation logic varies by type | Only one concrete type exists |
| Builder | >3 constructor params or optional config | Simple objects with few fields |
| Singleton | Truly global shared resource (config, pool) | "Convenience" — use DI instead |

## Structural

| Pattern | When to Use | Avoid When |
|---------|-------------|------------|
| Adapter | Bridging incompatible interfaces | You control both interfaces |
| Decorator | Adding behavior without subclassing | Simpler composition works |
| Facade | Simplifying complex subsystem access | Hiding needed flexibility |

## Behavioral

| Pattern | When to Use | Avoid When |
|---------|-------------|------------|
| Strategy | Swappable algorithms at runtime | Only one algorithm exists |
| Observer | Decoupled event notification | Simple direct method calls suffice |
| Command | Undo/redo, queuing, logging operations | Simple one-shot operations |

## Anti-Patterns

| Anti-pattern | Why Harmful | Better Alternative |
|---|---|---|
| God Object | Unmaintainable, untestable | Split by responsibility |
| Premature Abstraction | Complexity without benefit | Extract when you see duplication |
| Singleton Abuse | Hidden dependencies, testing nightmare | Dependency injection |
| Inheritance for Reuse | Tight coupling, fragile base class | Composition and interfaces |
