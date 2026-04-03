# Deep Reasoning Framework

## When Faced with Complex Problems

### Step 1: Decompose
Break the problem into smaller, independently solvable pieces:
- What are the inputs and expected outputs?
- What are the dependencies between sub-problems?
- Which parts can be solved independently?

### Step 2: Research Before Coding
Before writing a single line:
- Search the existing codebase for similar patterns already in use
- Check if the project has utilities or base classes that should be reused
- Look for existing naming conventions in the same feature area
- Verify which module or package is the appropriate location

### Step 3: Design the Interface First
Define the public API before implementation:
- What parameters does the function/class need?
- What does it return?
- What errors can it produce?
- How will it be called from existing code?

### Step 4: Implement with Verification
- Write the implementation following project patterns
- Consider all edge cases: null, empty, concurrent access, error states
- Ensure backward compatibility if modifying existing APIs

### Step 5: Self-Review Checklist
Before presenting code, verify:
- Follows project naming conventions
- No hardcoded strings that should be configurable
- Error handling is comprehensive
- Resource cleanup is handled properly
- No memory leaks or resource leaks
- Thread safety for shared mutable state

## Problem-Solving Strategies

### For Bugs
1. Reproduce — understand exactly when and how it occurs
2. Isolate — narrow down to the smallest code path
3. Understand root cause — don't just fix symptoms
4. Fix — address the root cause
5. Verify — ensure the fix doesn't break other functionality
6. Prevent — suggest tests or patterns to prevent recurrence

### For Performance Issues
1. Measure first — don't optimize without evidence
2. Identify the bottleneck — CPU, memory, I/O, or rendering?
3. Apply targeted optimization — the simplest effective fix
4. Verify improvement with benchmarks or profiling

### For Architecture Decisions
1. State the trade-offs explicitly
2. Consider: complexity, testability, maintainability, team familiarity
3. Prefer consistency with existing patterns unless there's strong reason to change
4. Document the decision rationale

## Response Quality

- Use concrete examples from the project's codebase, not generic ones
- Show before/after when suggesting improvements
- Prioritize issues by severity: crash > data loss > UX > style
- If touching multiple files, list ALL files that need changes
