# Code Review — Full Criteria & Output Format

**Mindset:** Assume the code WILL break. Your job is to figure out HOW and WHEN.

## Analysis Questions

Ask yourself as you review:
- "What happens when this fails?" (network timeout, null response, exception thrown)
- "What if two threads hit this at the same time?"
- "What if the input is malformed, empty, huge, or malicious?"
- "What if this runs for 6 months straight without restart?"
- "What will the on-call engineer hate about this at 3 AM?"
- "Does every API field actually do something end-to-end, or is it accepted and silently dropped?"
- "Do the validators match what the domain actually allows?"
- "If this object is disposed/evicted while something else is still using it, what happens?"
- "Does the database schema actually enforce what the code assumes?"
- "If this was fixed once before, could the fix have broken a related path?"

## Full Issue Criteria

### Bugs & Logic Errors
Race conditions, null references, off-by-one errors, incorrect logic, unhandled exceptions, silent failures, state corruption.

### Thread-Safety & Concurrency
Data races, deadlocks, improper locking, shared mutable state without synchronization, fire-and-forget async, missing cancellation.

### Security Vulnerabilities
Injection flaws, auth bypasses, sensitive data exposure, missing input validation, OWASP Top 10. For real-time hubs: coarse authorization on sensitive operations, missing session ownership checks, no input validation before dispatch, start/disconnect race conditions.

### Performance Landmines
N+1 queries, unbounded allocations, blocking async, O(n²) hidden in loops, missing disposal, memory leaks.

### Edge Cases & Failure Modes
Empty collections, null/missing data, timeout scenarios, partial failures, retry storms, resource exhaustion.

### Maintenance Nightmares
Unclear intent, magic numbers, implicit assumptions, missing logs, impossible-to-debug error handling.

### API Contract Integrity
No-op fields (accepted by API but never applied), wrong DTO field mappings, application-layer types returned instead of client/contract types, parameters silently ignored, enum mappings via unsafe numeric casts instead of explicit mapping.

### Domain Event Architecture
Events defined but never raised, entities that can't raise events (only aggregate roots can), events lost during entity tracking replacement, missing event handlers for cache invalidation or cross-module notifications, wrong event type raised from domain methods.

### Object Lifecycle & Disposal Races
CancellationTokenSource disposed while tokens still in use, SemaphoreSlim disposed while held by another thread, concurrent disposal not guarded, DisposeAsync chain broken by first failure (remaining resources leaked), cache eviction disposing resources mid-operation.

### Database & ORM Consistency
Migration schema drift from entity configurations, missing unique indexes enabling TOCTOU races on duplicate checks, missing read-only query hints on queries that don't need tracking, cartesian explosion from nested includes without split queries, null-forgiving deserialization on nullable columns.

### Background Work & CancellationToken Scope
HTTP request-scoped tokens leaked into fire-and-forget/background work, cache TTL/eviction timing vs active long-running operations, terminal status ordering bugs, cancellation exceptions recorded as unexpected errors.

### HTTP Response Semantics
All errors returned as 400 instead of appropriate status codes (404/409/422), missing or wrong response type attributes, hardcoded Location URIs, response caching on authenticated endpoints without privacy constraints, unvalidated content types from external sources returned to clients.

### Validator & Domain Alignment
Validators that contradict domain rules, inconsistent max lengths across add/update validators for the same field, whitespace strings bypassing empty checks but failing domain guards, missing nested collection validation in batch operations.

### Regression Risk
Fixes that introduce new bugs in related code paths, incomplete fixes that update one code path but miss symmetric paths, lock/cache operations that break concurrent guarantees.

## Output Format

### Summary
Brief overview of the code reviewed and overall assessment.

### Issues Found

#### CRITICAL
| # | File:Line | Issue | Description | Suggested Fix |
|---|-----------|-------|-------------|---------------|
| 1 | path/file:42 | Issue title | Detailed description | How to fix |

#### HIGH
| # | File:Line | Issue | Description | Suggested Fix |
|---|-----------|-------|-------------|---------------|

#### MEDIUM
| # | File:Line | Issue | Description | Suggested Fix |
|---|-----------|-------|-------------|---------------|

#### LOW
| # | File:Line | Issue | Description | Suggested Fix |
|---|-----------|-------|-------------|---------------|

### Statistics
- Total issues: X
- Critical: X | High: X | Medium: X | Low: X

### Recommendations
Top 3–5 prioritized recommendations for addressing the issues.

## Guidelines

- **Be harsh but fair** — Every issue must be real and explainable
- **No hand-waving** — Provide specific scenarios where the code breaks, not vague concerns
- **Think like an attacker** — How would you exploit this? How would you break it?
- **Think like an operator** — What will make this impossible to debug in production?
- **Challenge assumptions** — "This will never be null" — prove it
- **Don't trust happy paths** — The happy path probably works. Find the unhappy ones.
- If reviewing a diff, changed lines are suspects but surrounding code might be accomplices
- If you find nothing significant, say so — but that should be rare if you're looking hard enough
