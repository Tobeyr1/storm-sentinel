---
paths:
  - "**/*.kt"
---

# Kotlin Jetpack Development Guidelines

## Kotlin Language
- Follow Kotlin official coding conventions
- PascalCase for classes, camelCase for functions/properties, UPPER_SNAKE_CASE for constants
- Use scope functions (let, apply, run, with, also) for readability
- Prefer val over var, data classes for models, sealed classes for states
- Higher-order functions for collection operations
- Avoid !! — use safe calls, Elvis operator, or let

## Jetpack Components

### ViewModel
- One ViewModel per screen
- Expose data through StateFlow (not LiveData)
- Business logic only, no UI logic
- Use SavedStateHandle for state persistence

### Flow & StateFlow
- Return Flow from Repository layer
- Use viewModelScope/lifecycleScope for collection
- StateFlow for state management

### Lifecycle
- repeatOnLifecycle or collectAsStateWithLifecycle for safe collection
- Register/unregister callbacks in matching methods

### Compose
- State Hoisting for UI state
- Single responsibility components
- collectAsStateWithLifecycle() for Flow to State
- LaunchedEffect for side effects

## Performance
- LazyColumn/LazyRow for lists
- remember/derivedStateOf to minimize recomposition
- Coil for image loading
- Data prefetching and caching

## Security
- EncryptedSharedPreferences for sensitive data
- HTTPS with certificate pinning
- Validate all user input
- Never log sensitive information
