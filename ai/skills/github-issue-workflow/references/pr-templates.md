# PR Body Templates

Choose the template that matches the type of change.

---

## Bug Fix

```markdown
## Summary
Fixes <brief description of the bug>.

## Root Cause
<1-2 sentences explaining why the bug happened>

## Changes
- <file/module>: <what changed>
- <file/module>: <what changed>

## Tests
- Added regression test: `<test name>` covering <scenario>
- All existing tests pass

## Docs updated
- [ ] Yes — updated `./docs/<file>`
- [ ] N/A — no public API/behaviour changes

Closes #<N>
```

---

## Feature / Enhancement

```markdown
## Summary
Implements <feature name> as described in #<N>.

## Changes
- <file/module>: <what was added>
- <file/module>: <what was added>

## Tests
- Unit tests: <what's covered>
- Edge cases: <list any non-obvious edge cases tested>
- All existing tests pass

## Docs updated
- [ ] Yes — updated `./docs/<file>` with new API docs
- [ ] N/A — no public API/behaviour changes

## Notes for reviewer
<Anything the reviewer should pay special attention to, or known trade-offs>

Closes #<N>
```

---

## Refactor / Chore

```markdown
## Summary
<Brief description of the refactor — what was cleaned up and why>

## Changes
- <file/module>: <what changed>

## Tests
- No new tests needed (pure refactor — no behaviour change)
- All existing tests pass

## Docs updated
- [ ] N/A — no public API/behaviour changes

Closes #<N>
```

---

## Breaking Change

```markdown
## ⚠️ BREAKING CHANGE — Summary
<What broke and why this change was necessary>

## Migration Guide

**Before:**
```js
// old usage
```

**After:**
```js
// new usage
```

## Changes
- <file/module>: <what changed>

## Tests
- Updated tests to reflect new API
- Added migration-path tests
- All tests pass

## Docs updated
- [ ] Yes — updated `./docs/<file>` with migration notes marked ⚠️ BREAKING

Closes #<N>
```
