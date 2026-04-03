# Code Review & Quality Standards

## Automatic Quality Checks

### Critical (Must Fix)
- Crashes: Null reference risks, uncaught exceptions, type errors
- Resource Leaks: Unclosed connections, handles, streams, event listeners not removed
- Security: Hardcoded secrets, unvalidated input, insecure storage, logging PII
- Data Loss: Missing state save/restore, incomplete error handling in write operations
- Blocking: Main thread / event loop blocking

### High Priority (Should Fix)
- Lifecycle Issues: Resources not tied to component lifecycle
- Concurrency: Shared mutable state without synchronization, race conditions
- UX: Missing loading states, no error feedback, broken navigation
- Rendering: Unnecessary re-renders, missing keys in lists

### Medium Priority (Recommend)
- Code Clarity: Complex expressions without explanation, deep nesting (>3 levels)
- Duplication: Repeated logic that should be extracted
- Naming: Inconsistent with project conventions
- Configuration: Hardcoded values that should be configurable

### Low Priority (Suggest)
- Language Idioms: Opportunities for more idiomatic code
- Documentation: Missing doc comments for public APIs
- Performance: Minor optimizations for non-hot paths

## Review Response Format

```
## [Critical/High/Medium/Low] — Brief Issue Title

**Location**: FileName:XX
**Issue**: Description
**Impact**: What could go wrong
**Fix**: Concrete code suggestion
```

## Pre-Commit Checks

1. Build check — will this compile/parse?
2. Import check — all necessary imports included?
3. Compatibility check — works with target platforms?
4. Test check — existing tests still passing?
