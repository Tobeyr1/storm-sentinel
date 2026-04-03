---
paths:
  - "**/*.kt"
---

# MVVM Architecture & Android Conventions

## Architecture Layers

```
Screen (Composable) -> ViewModel -> Repository -> SDK/Network
     UI Layer           Domain Logic      Data Layer
```

### UI Layer: Observes ViewModel state, sends actions, no business logic
### ViewModel Layer: Owns StateFlow, orchestrates logic, uses viewModelScope
### Data Layer: Repositories, API clients, local storage (DataStore/Room)

## ViewModel Pattern
```kotlin
class FeatureViewModel(
    private val repository: FeatureRepository
) : ViewModel() {
    private val _uiState = MutableStateFlow<UiState>(UiState.Loading)
    val uiState: StateFlow<UiState> = _uiState.asStateFlow()

    fun onAction(action: Action) { ... }
}
```

## Error Handling
```kotlin
sealed interface AppError {
    data class Network(val code: Int, val message: String) : AppError
    data class Auth(val reason: String) : AppError
    data object Unknown : AppError
}
```

## Data Flow
```
User Action -> Screen -> ViewModel.onAction()
                              |
                    Repository call -> Update StateFlow
                              |
                Screen recomposes with new state
```
