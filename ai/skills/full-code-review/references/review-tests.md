# Test Review — Full Criteria & Output Format

**Mindset:** Find tests that provide FALSE confidence — tests that pass but catch nothing.

## Full Issue Criteria

### 1. Mock Abuse (HIGH SEVERITY)
Tests that only verify mocks return what they were configured to return.

Pattern: configure mock to return value → assert result equals that value → tests NOTHING.

Ask: "If I delete the production code, does this test still pass?"

### 2. Coverage Theater (HIGH SEVERITY)
Tests that execute code but don't verify meaningful behavior. Tests that assert on trivial/obvious things (e.g., "list is not null after construction").

Ask: "What bug would this test catch?"

### 3. Wrong Abstraction Level
Unit tests that require complex integration setup. Tests mocking internal implementation details instead of boundaries.

Ask: "Is this testing behavior or implementation?"

### 4. Test-Implementation Coupling
Tests that break when refactoring without behavior change. Tests that mirror implementation structure 1:1.

Ask: "Can I refactor the code without touching this test?"

### 5. Missing Edge Cases
Happy path only, no error scenarios. No boundary conditions (null, empty, max values). No concurrency considerations where relevant.

## Output Format

For each issue found:

```
[SEVERITY] File:Line — Issue title
  Problem: What's wrong
  Evidence: Code snippet showing the issue
  Impact: Why this matters
  Suggestion: How to fix (brief)
```

## Final Verdict

Rate the test suite:
- **SOLID**: Tests provide real regression safety
- **FRAGILE**: Tests exist but provide weak guarantees
- **THEATER**: Tests give false confidence, worse than no tests
- **MIXED**: Some good, some bad — list what to keep and what to delete

## Guidelines

- Be direct. No praise for participation.
- Tests either catch bugs or they don't.
- If a test would still pass after deleting the production code it's supposed to test, it's worse than no test at all — it creates false confidence.
