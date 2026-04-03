# Testing Guide

Practical testing patterns. Test behavior, not implementation.

## Test Pyramid

| Level | Scope | Speed | Count |
|-------|-------|-------|-------|
| Unit | Single function/class | Fast (<1ms) | Many |
| Integration | Module boundaries | Medium (<1s) | Moderate |
| E2E | Full user flows | Slow (seconds) | Few |

## Unit Test Structure (AAA)

```
Arrange → set up test data and dependencies
Act     → call the function under test
Assert  → verify the expected outcome
```

## Naming Convention

`test_[unit]_[scenario]_[expectedResult]`

## What to Test

| Always Test | Skip Testing |
|---|---|
| Business logic and calculations | Simple getters/setters |
| Edge cases (null, empty, boundary) | Framework internals |
| Error handling paths | Trivial delegation methods |
| State transitions | Private implementation details |

## Mocking Guidelines

| Do | Don't |
|---|---|
| Mock external dependencies (DB, API, filesystem) | Mock the class under test |
| Verify interactions at boundaries | Mock value objects |
| Use fakes for complex dependencies | Over-mock (>3 mocks = design smell) |

## Anti-Patterns

| Anti-pattern | Why Harmful | Fix |
|---|---|---|
| Testing implementation | Breaks on refactor | Test public behavior |
| Flaky tests | Erode trust in test suite | Isolate, use deterministic data |
| No assertions | False confidence | Every test needs meaningful assertions |
| Test interdependence | Order-dependent failures | Each test sets up its own state |
