---
paths:
  - "**/*.kt"
---

# Android & Kotlin Coding Standards

## Kotlin Style

### Prefer Kotlin Idioms
```kotlin
user?.let { updateUI(it) }
binding.apply { title.text = name; subtitle.text = desc }

when (state) {
    is State.Loading -> showLoading()
    is State.Success -> showData(state.data)
    is State.Error -> showError(state.message)
}
```

### Null Safety
- Never use `!!` except in tests. Use `?.`, `?:`, `let`, or `requireNotNull`.
- Prefer non-null types in public APIs.

### Coroutines
- viewModelScope in ViewModels, lifecycleScope in Activities/Fragments
- withContext(Dispatchers.IO) for disk/network
- Never use GlobalScope
- Always rethrow CancellationException

### Collections
- List (immutable) by default, MutableList only when needed
- Prefer map, filter, flatMap, groupBy
- sequence {} for large chains

## Android Specifics

### Lifecycle Awareness
- Collect Flows in repeatOnLifecycle(STARTED) or collectAsStateWithLifecycle()
- Register/unregister callbacks in matching lifecycle methods

### Resources
- String resources for user-visible text
- Dimension/color resources through theme, not hardcoded

### ProGuard/R8
- Verify ProGuard rules when adding libraries
- Add keep rules when using reflection
