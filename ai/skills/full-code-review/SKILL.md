---
name: code-review
description: >
  Expert-level code review, architecture review, test suite review, and code documentation. Use this skill
  whenever the user asks to review code, review tests, review architecture or design, document code, audit
  a module, find bugs, check for code smells, evaluate test quality, add comments, or assess any codebase
  artifact. Triggers on phrases like "review this", "review my tests", "review the architecture", "document
  this code", "check for bugs", "audit the code", "what's wrong with", "find issues in", or any request
  to evaluate the quality of code, tests, or design. Always use this skill for any substantive code
  quality task — don't try to wing it.
---

# Code Review Skill

Four review modes, each ruthless and pragmatic. Choose the right one based on what the user asks for.

## Choosing the Right Mode

| User wants... | Mode |
|---|---|
| Bug hunting, logic errors, security flaws, production risk | **[Code Review](#code-review)** |
| Test quality, false confidence, mock abuse | **[Test Review](#test-review)** |
| Structure, dependencies, layer violations, scalability | **[Architecture Review](#architecture-review)** |
| Adding comments, explaining intent, why not what | **[Document Code](#document-code)** |

If the user's request is ambiguous, ask which mode they want before proceeding.

## Getting the Target

**Always resolve the target before reviewing.** The user can specify:
- `staged` / `staged changes` → `git diff --cached`
- `uncommitted` / `uncommitted changes` → `git diff`
- A natural language description → search the codebase for matching files
- An explicit path → read directly

**If no target is provided, ask:** "What would you like me to review? You can give me a file path, describe the module, or say 'staged changes'."

Once you have the target, read all relevant files completely before forming any opinions.

---

## Code Review

> See `references/review-code.md` for full criteria and output format.

**Mindset:** Assume the code WILL break. Figure out HOW and WHEN.

**Quick checklist of what to hunt for:**
- Bugs & logic errors (null refs, off-by-one, silent failures, state corruption)
- Thread safety & concurrency (races, deadlocks, fire-and-forget async)
- Security (injection, auth bypass, missing validation, OWASP Top 10)
- Performance (N+1 queries, unbounded allocations, blocking async, memory leaks)
- Edge cases (empty collections, timeouts, partial failures, retry storms)
- API contract integrity (no-op fields, wrong DTO mappings, ignored parameters)
- Object lifecycle & disposal races
- HTTP response semantics (wrong status codes, missing attributes)
- Regression risk (fixes that break related paths)

**Severity levels:** CRITICAL → HIGH → MEDIUM → LOW

Read `references/review-code.md` for the full criteria list and the exact output table format to use.

---

## Test Review

> See `references/review-tests.md` for full criteria and output format.

**Mindset:** Find tests that provide FALSE confidence — tests that pass but catch nothing.

**Quick checklist:**
- Mock abuse: tests that only verify mocks return configured values
- Coverage theater: code executed but no meaningful behavior verified
- Wrong abstraction level: unit tests with integration-level setup
- Test-implementation coupling: tests that break on refactor without behavior change
- Missing edge cases: happy path only, no error scenarios, no boundary conditions

**Final verdict:** SOLID / FRAGILE / THEATER / MIXED

Read `references/review-tests.md` for the full criteria and output format.

---

## Architecture Review

> See `references/review-architecture.md` for full criteria and output format.

**Mindset:** Assume this system WILL grow 10x. Find where it cracks under pressure.

**Process:** Before analyzing, map the architecture:
- Identify layers (presentation, application, domain, infrastructure)
- Trace dependencies between components/modules
- Identify abstraction boundaries and interfaces
- Note DI patterns and data flow

**Quick checklist:**
- Dependency issues (circular deps, missing abstractions, coupling to concretions)
- Layer violations (business logic in controllers, infrastructure in domain)
- SOLID violations (SRP, OCP, LSP, ISP, DIP)
- Scalability concerns (bottlenecks, SPOFs, shared mutable state)
- Fault isolation & blast radius
- Resource lifecycle & cleanup (eviction/TTL, shutdown ordering, orphaned resources)
- Declared vs actual capability consistency
- Graceful degradation & partial failure

**Overall rating:** HEALTHY / CONCERNING / PROBLEMATIC / CRITICAL

Read `references/review-architecture.md` for the full criteria and output format.

---

## Document Code

> See `references/document-code.md` for full criteria and output format.

**Mindset:** If a competent developer can understand it from the code, it doesn't need a comment. Comments explain *why*, never *what*.

**The bar is HIGH.** Only add documentation when:
1. The "why" is invisible (algorithm choice, order of operations, specific threshold)
2. Design decisions that would puzzle a new developer
3. Non-obvious constraints (protocol quirks, external system behaviors)
4. Subtle correctness (race condition mitigations, intentional fallthrough)
5. Cross-cutting contracts ("Caller must hold lock", "Order matters: X before Y")

**Never document:** what the code does, obvious patterns, things good naming already communicates.

Apply the **5-second test**: would a competent developer stare at this for 5+ seconds wondering "why"? If yes, add a comment. If no, skip it.

Read `references/document-code.md` for the comment style guide and output format.
