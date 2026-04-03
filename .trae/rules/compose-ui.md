---
paths:
  - "**/*.kt"
---

# Jetpack Compose Best Practices

## Recomposition Optimization

### Use Stable Types
```kotlin
// Bad: unstable lambda
@Composable
fun ItemList(items: List<Item>) {
    LazyColumn {
        items(items) { item ->
            ItemRow(item, onClick = { viewModel.onItemClick(item) })
        }
    }
}

// Good: stable reference
@Composable
fun ItemList(items: List<Item>, onItemClick: (Item) -> Unit) {
    LazyColumn {
        items(items, key = { it.id }) { item ->
            ItemRow(item, onClick = { onItemClick(item) })
        }
    }
}
```

### Remember & Keys
```kotlin
val sortedList = remember(items) { items.sortedBy { it.name } }
val derivedValue by remember { derivedStateOf { items.count { it.isSelected } } }
```

## State Management — StateFlow Pattern
```kotlin
class FeatureViewModel : ViewModel() {
    private val _uiState = MutableStateFlow(FeatureUiState())
    val uiState: StateFlow<FeatureUiState> = _uiState.asStateFlow()
}

// In Composable
val uiState by viewModel.uiState.collectAsStateWithLifecycle()
```

## Screen vs Component
- **Screen**: Top-level, connected to ViewModel, named `*Screen`
- **Component**: Reusable stateless UI, takes data + callbacks

## Material3 Theming
- MaterialTheme.colorScheme.* for colors, never hardcoded
- MaterialTheme.typography.* for text styles
- Support light and dark themes

## Loading/Error/Content Pattern
```kotlin
when (uiState) {
    is Loading -> LoadingIndicator()
    is Error -> ErrorMessage(uiState.message)
    is Success -> SuccessContent(uiState.data)
}
```
