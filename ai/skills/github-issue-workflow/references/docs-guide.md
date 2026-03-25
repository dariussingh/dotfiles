# Developer Docs Guide
 
This reference defines how to write and organise the `./docs/` directory.
 
---
 
## Purpose
 
`./docs/` contains **developer-facing API and usage documentation** — written for developers who will *use* the framework, not maintain it.
 
It is **not**:
- Architecture diagrams or internal design notes
- Onboarding guides for contributors
- Changelogs (keep those in CHANGELOG.md)
 
---
 
## Directory Structure
 
```
docs/
├── README.md              ← Overview + quick-start (entry point)
├── getting-started.md     ← Installation, setup, first example
├── api/
│   ├── README.md          ← API index
│   ├── <module-name>.md   ← One file per public module/class/namespace
│   └── ...
├── guides/
│   ├── <topic>.md         ← How-to guides for common patterns
│   └── ...
└── reference/
    ├── configuration.md   ← All config options, their types and defaults
    ├── errors.md          ← Error codes, messages, and how to handle them
    └── ...
```
 
Add directories only as needed — don't pre-create empty stubs.
 
---
 
## What to Document
 
### Always document
- Every public function / method / class with: purpose, parameters (name, type, description, default), return value, throws/errors, example usage
- Every configuration option with: key name, type, default, effect, example
- Every error code or exception the user may encounter
- CLI commands and flags if the framework has a CLI
 
### Document when changed
- Behaviour changes — what changed and what the new behaviour is
- Breaking changes — clearly mark as **BREAKING** and show migration example
- New defaults — note the old default and new default
 
### Do NOT document
- Internal implementation details
- Private functions (prefix `_` or equivalent)
- Architecture decisions (those live in ADRs elsewhere)
 
---
 
## Page Template — API Module
 
```markdown
# `<ModuleName>`
 
Brief one-line description.
 
## Overview
 
2-3 sentences explaining what this module does and when to use it.
 
## Installation / Import
 
```js
import { Foo } from 'my-framework/foo'
```
 
## Functions / Methods
 
### `functionName(param1, param2)`
 
Description of what it does.
 
**Parameters**
 
| Name | Type | Default | Description |
|------|------|---------|-------------|
| param1 | `string` | — | What it is |
| param2 | `number` | `0` | What it is |
 
**Returns** `Promise<Result>` — description of the result shape.
 
**Throws**
- `ValidationError` — when param1 is empty
- `NetworkError` — when the upstream call fails
 
**Example**
 
```js
const result = await functionName('hello', 42)
console.log(result.value)
```
 
---
 
## Changelog (module-level)
 
| Version | Change |
|---------|--------|
| 1.2.0 | Added `param2` option |
| 1.0.0 | Initial release |
```
 
---
 
## Writing Style
 
- **Second person** ("You can configure…", not "The user can configure…")
- **Present tense** ("Returns a string", not "Will return a string")
- **Short sentences.** Break complex explanations into bullet points.
- **Show, don't just tell.** Every function should have at least one code example.
- **Mark breaking changes clearly**: prefix the section or changelog entry with `⚠️ BREAKING:`.
- **Keep code examples runnable** — they should work copy-pasted with minimal setup.
 
---
 
## When to Update Docs
 
| Change made | Doc action required |
|-------------|---------------------|
| New public function/method | Add to the relevant `api/<module>.md` |
| Changed function signature | Update parameter table + example |
| Changed default value | Update default column + note old value |
| New config option | Add to `reference/configuration.md` |
| New error / changed error message | Update `reference/errors.md` |
| New CLI flag | Update CLI section |
| Removed / deprecated API | Mark deprecated in-place; add to deprecation list at top of page |
| Bug fix with no API change | No doc update needed (add to CHANGELOG.md only) |
 
---
 
## Deprecation Pattern
 
When deprecating something, don't delete it immediately. Mark it:
 
```markdown
### `oldFunction(x)` ⚠️ Deprecated since v2.1
 
Use [`newFunction(x, y)`](#newFunction) instead.
 
<details>
<summary>Old docs (kept for reference)</summary>
 
...old content...
 
</details>
```
 
Remove fully in the next major version.
 
