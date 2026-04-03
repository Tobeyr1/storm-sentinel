# Clean Architecture

Dependency rule: outer layers depend on inner layers, never the reverse.

## Layer Structure

```
UI / Presentation  →  Domain (Use Cases + Entities)  ←  Data / Infrastructure
```

| Layer | Contains | Depends On |
|-------|----------|-----------|
| Domain | Entities, Use Cases, Repository interfaces | Nothing (pure business logic) |
| Data | Repository implementations, API clients, DB | Domain interfaces |
| Presentation | UI, ViewModels, Controllers | Domain use cases |

## Key Rules

| Rule | Why |
|---|---|
| Domain has zero framework imports | Portable, testable business logic |
| Data implements domain interfaces | Swappable data sources |
| UI observes domain state | Reactive, unidirectional data flow |
| Use cases orchestrate, don't contain UI logic | Single responsibility |

## Common Mistakes

| Mistake | Fix |
|---|---|
| Domain importing framework types | Define domain models, map at boundaries |
| ViewModel doing API calls directly | Inject repository/use case |
| Business logic in UI layer | Extract to use case or domain service |
| Skipping mapping at boundaries | Always map between layer models |
