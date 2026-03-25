# Document Code — Full Criteria & Output Format

**Mindset:** If a competent developer can understand it from the code, it doesn't need a comment. Comments explain *why*, never *what*.

## When to Add Documentation

The bar is HIGH. Only add documentation when:

1. **The "why" is invisible** — The code does something correct but the reason isn't obvious. Why this algorithm over a simpler one? Why this order of operations? Why this specific threshold?
2. **Design decisions** — Architectural choices that would puzzle a new developer. Why two-phase validation? Why best-effort instead of strict? Why this data flow direction?
3. **Non-obvious constraints** — Business rules, protocol quirks, or external system behaviors. "Spec requires X before Y", "DB returns stale reads for 5s after write."
4. **Subtle correctness** — Code that looks wrong but is intentionally written that way. Race condition mitigations, intentional fallthrough, defensive ordering.
5. **Cross-cutting contracts** — Implicit agreements between components. "Caller must hold lock", "Called only from reconciliation loop", "Order matters: X before Y."

## Never Document

- What the code does (the code says that)
- Method signatures, parameter names, or return types (self-documenting)
- Obvious patterns (null checks, standard DI, CRUD operations)
- Things that good naming already communicates
- Boilerplate doc comments on internal classes
- Restatements of the type system ("`// Returns a list of users`")

## The 5-Second Test

For each potential comment: would a competent developer stare at this for more than 5 seconds wondering "why"?
- YES → add a comment
- NO → move on
- When in doubt, leave it out. Unnecessary comments are noise that makes the necessary ones harder to find.

## Process

1. Read each file completely. Understand the full context before deciding if comments are needed.
2. Trace cross-file dependencies. A comment in one file might reference behavior in another.
3. Check existing comments. Don't duplicate or contradict them.
4. For each potential comment, apply the 5-second test.
5. Write comments as short as possible. One line is ideal. Two lines maximum unless truly complex.

## Comment Style Guide

```
// GOOD: Explains why
// Clone request because HttpRequestMessage can't be sent twice
clonedRequest = await CloneHttpRequestMessageAsync(request);

// GOOD: Non-obvious design decision
// Best-effort push: DB is authoritative; server syncs on next reconciliation if push fails
pushResult = await client.PushAsync(...);

// GOOD: Subtle correctness
// Clean up stale reverse mapping so a delayed disconnect doesn't unregister the new connection
connectionMap.TryRemove(existingConnectionId, out _);

// BAD: Restates the code
// Get the server from the repository
var server = await _repository.GetAsync(id, ct);

// BAD: Obvious from naming
// Check if server is null
if (server is null) ...

// BAD: Boilerplate
/// <summary>
/// Handles the command to update a recording assignment.
/// </summary>
```

Match the existing style of the codebase. If it uses `//` inline comments, don't switch to XML doc comments.

## Output Format

### Summary
Brief overview of the code analyzed and what was found.

### Documentation Added

| # | File:Line | Comment | Rationale |
|---|-----------|---------|-----------|
| 1 | path/file:42 | The comment text added | Why this needed documentation |

### Documentation Considered but Rejected

| # | File:Line | Considered | Reason Rejected |
|---|-----------|------------|-----------------|
| 1 | path/file:10 | Considered documenting X | Self-evident from naming/context |

### TODOs Added

| # | File:Line | TODO | Context |
|---|-----------|------|---------|
| 1 | path/file:99 | TODO text | Why it's deferred |

### Statistics
- Files analyzed: X
- Comments added: X
- Comments considered but rejected: X
- TODOs added: X

## Guidelines

- **Less is more** — 5 perfect comments beat 50 mediocre ones. Every unnecessary comment dilutes the signal.
- **Comments rot** — Every comment is a maintenance burden. Only add ones worth maintaining.
- **If you need a comment, first ask if the code can be clearer** — Better naming, extracting a method, or restructuring often eliminates the need for a comment.
- **Be concise** — Write like you're paying per character. Cut every word that doesn't add meaning.
- **No essay comments** — If a comment needs a paragraph, the code needs refactoring instead.
- If you find nothing worth documenting, say so clearly. That's a sign of well-written code, not a failure.
