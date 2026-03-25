---
name: github-issue-workflow
description: >
  Use this skill whenever working on a GitHub project that has issues, milestones, or a backlog to process.
  Triggers on: "work on issues", "fix the next issue", "process the backlog", "start on milestone X",
  "pick up an issue", "work through issues one by one", "implement issue #N", or any request to make
  progress on a GitHub repo with open issues. Enforces branch-per-issue, TDD, PR-per-issue, and
  sequential (non-parallel) issue resolution. Always use this skill when the user references issues,
  PRs, milestones, or a development backlog — even if they only say "let's get started" in a repo context.
---

# GitHub Issue Workflow Skill

A disciplined, sequential workflow for working through GitHub issues one at a time:
branch → implement (TDD) → PR → await review → next issue.

**Core rules (never break these):**
1. One issue at a time. Never start the next until the current PR is open and linked.
2. Only pick an issue if it has **no existing open PR** already associated with it. Check before starting.
3. **No auto-merge. Ever.** Always leave PRs open for human review. Never pass `--merge`, enable auto-merge, or merge via any other mechanism.
4. **Default branch is `main`. All PRs target `main`.** Never change the default branch. Never merge to any branch other than `main` — if a situation seems to require merging into a different branch, **stop and ask the user explicitly** before doing anything.
5. **Never bypass branch protection rules.** Work within whatever rules are configured (required reviews, status checks, etc.). Never use `--admin` overrides or force-push to protected branches.
6. **Always pull the latest `main` before branching.** Never branch off a stale local copy.
7. **Complete all issues in the current milestone phase before starting any issue in the next phase.** Finish all Phase 1 issues before touching any Phase 2 issue, and so on.
8. **Always ask the user for explicit permission before starting work on any issue.** Present the chosen issue and wait for approval before creating a branch or writing any code.
9. TDD: write (or update) tests first, then make them pass.
10. Keep developer docs (`./docs/`) in sync with every change that affects the public API or behaviour.
11. Pick issues with no unfinished blockers first. Prefer the lowest issue number that meets all criteria.

---

## Step 0 — Startup (run once per session)

Before touching any issue, orient yourself:

```bash
# 1. Always pull the latest main first
git checkout main && git pull origin main

# 2. Confirm the remote default branch matches main
git remote show origin | grep "HEAD branch"

# 3. Read the project startup docs
#    Default path: ../startup — try common locations
cat ../startup/*.md 2>/dev/null \
  || cat ../startup/README.md 2>/dev/null \
  || echo "NOT FOUND"
```

**If the startup docs are not found:**
Stop and ask the user:
> "I couldn't find the startup docs at `../startup`. Where are they located?"

Do not proceed until you've read the startup docs or the user confirms there are none.

```bash
# 4. List open issues, grouped by milestone
gh issue list --state open --json number,title,milestone,labels \
  | jq 'group_by(.milestone.title)'
```

---

## Step 1 — Pick the Next Issue

### Selection rules (strict priority order)
1. **No existing open PR.** Skip any issue that already has an open PR associated with it.
2. **No unfinished blockers.** Check `gh issue view <N>` for "blocked by" language or linked open issues.
3. **Current milestone phase only.** Identify the lowest-numbered milestone phase that has any open issues. Do not pick any issue from a later phase until every issue in the current phase has an open (or merged) PR.
4. **Within the current phase**, prefer issues labelled `bug` > `enhancement` > `chore`.
5. **Within a label group**, pick the **lowest issue number** first (oldest first).

```bash
# View a candidate issue in full before committing to it
gh issue view <N>

# Check if an issue already has an associated PR
gh pr list --state open --json number,title,body \
  | jq '.[] | select(.body | test("#<N>"))'
# Also check via the issue's timeline
gh issue view <N> --json timelineItems
```

If an issue already has an open PR, skip it and note: "Issue #N already has PR #M open — skipping."

### Ask for permission before starting

Once you've identified the best candidate, **stop and ask the user**:

> "I'd like to work on **Issue #N: \<title\>** (\<milestone / phase\>).
> \<1-sentence summary of what it involves\>
> Shall I go ahead?"

**Do not create a branch, write any code, or take any action until the user says yes.**

---

## Step 2 — Create a Branch

Branch naming: `issue-<number>-<short-slug>`  
e.g. `issue-42-add-user-auth`

```bash
# Always pull the very latest main immediately before branching
git checkout main
git pull origin main
git checkout -b issue-<N>-<slug>
```

---

## Step 3 — Implement (TDD)

### 3a. Write failing tests first
- Read the issue description carefully. Understand acceptance criteria.
- Write tests that *will fail* until the feature/fix is implemented.
- Also write tests for edge cases you discover that don't have existing coverage.
- Run the test suite to confirm the new tests fail for the right reason:
  ```bash
  # Adjust command to the project's test runner
  npm test / pytest / go test ./... / etc.
  ```

### 3b. Implement the minimum code to make tests pass
- Keep changes focused on the issue. Avoid scope creep.
- Run the full test suite frequently.

### 3c. Refactor if needed
- Clean up while keeping all tests green.

### 3d. Final test run — all tests must pass
```bash
# Run full suite, not just new tests
npm test   # or equivalent
```

**Do not proceed to Step 4 if any test fails.**

---

## Step 4 — Update Developer Docs

Whenever your changes affect:
- A public API (new or changed function signatures, endpoints, config options)
- Observable behaviour (error handling, defaults, outputs)
- Setup or installation steps

…you **must** update `./docs/` before committing.

### Doc update rules
- `./docs/` contains developer/API docs — not architecture explanations.
- Write for developers who will *use* the framework, not maintain it.
- Update existing pages if the change modifies documented behaviour.
- Add a new page if you're introducing a new concept, module, or endpoint.
- Delete or mark deprecated anything that no longer applies.

See `references/docs-guide.md` for doc structure and style conventions.

---

## Step 5 — Commit

```bash
git add -A
git commit -m "fix/feat: <short description>

Closes #<N>

- <bullet summarising main change>
- <any notable edge cases handled>
- <tests added/updated>"
```

Follow the project's existing commit style if it differs from the above.

---

## Step 6 — Open a PR (no auto-merge, always target `main`)

```bash
git push origin issue-<N>-<slug>

gh pr create \
  --title "<Issue title> (#<N>)" \
  --body "$(cat <<'EOF'
## Summary
<1-2 sentence description>

## Changes
- <change 1>
- <change 2>

## Tests
- <what was tested>
- <edge cases covered>

## Docs updated
- [ ] Yes — updated `./docs/<file>`
- [ ] N/A — no public API/behaviour changes

Closes #<N>
EOF
)" \
  --base main \
  --draft=false
```

**Hard rules — never break:**
- Never pass `--merge` or any auto-merge flag.
- Always use `--base main`. Never target any other branch unless the user has explicitly instructed you to in that session.
- If the push or PR creation is rejected due to branch protection rules, **stop and report the error to the user**. Do not attempt to bypass or override protection rules.

### Link the issue
If not auto-closed by "Closes #N" in the PR body, manually link:
```bash
gh pr edit <PR-number> --add-label "" 
# Or via web: PR sidebar → "Development" → link issue
```

---

## Step 7 — Report and Pause

After the PR is open, report to the user:

```
✅ Issue #<N>: <title>
   Branch : issue-<N>-<slug>
   PR     : #<PR-N> — <link>
   Tests  : all passing
   Docs   : <updated file(s) | N/A>

Waiting for your review before moving to the next issue.
```

**Do not pick up the next issue until the user explicitly says to continue.**

---

## Step 8 — Next Issue

Once the user approves (they don't have to merge — just say "continue" or "next"):

```bash
git checkout main
git pull origin main   # always get the latest before picking the next issue
```

Then return to **Step 1**.

---

## Milestone Phase Enforcement

Milestones are worked in strict phase order. Before picking any issue, check:

```bash
gh issue list --state open --json number,title,milestone \
  | jq 'group_by(.milestone.title) | map({phase: .[0].milestone.title, count: length, issues: map(.number)})'
```

- Identify the **lowest phase** (e.g. "Phase 1", "Milestone 1", "v1.0") that still has open issues without a PR.
- **All issues in that phase must have an open or merged PR before any issue from the next phase can be started.**
- If a phase-N issue is blocked and no other phase-N issues are available, pause and inform the user rather than jumping to phase N+1.

Example report to give the user when pausing:
> "All unblocked Phase 1 issues now have PRs. Phase 1 still has Issue #7 which is blocked by #3 (open). I'll wait for your go-ahead before moving to Phase 2."

---

## Handling a Non-`main` Merge Target

If for any reason it appears a PR should target a branch other than `main` (e.g. a `dev`, `release/*`, or `staging` branch):

1. **Stop immediately.** Do not create the PR.
2. Ask the user explicitly:
   > "This PR would normally target `main`, but it looks like it may need to target `<other-branch>`. Can you confirm the intended base branch before I proceed?"
3. Only proceed with a non-`main` base after the user explicitly confirms in that session.
4. Even then, never auto-merge.

---

## Handling Blockers

If the chosen issue has an unresolved blocker:
1. Note it clearly: "Issue #N is blocked by #M which is still open."
2. Skip to the next eligible issue.
3. Come back to the blocked issue once #M's PR is merged.

---

## Quick Reference Card

| Step | Action | Gate |
|------|--------|------|
| 0 | Pull latest main → read startup docs (ask user if not found) → list issues | Once per session |
| 1 | Pick lowest-# issue in current phase (no existing PR, no blockers) → **ask user permission** | **Wait for yes** |
| 2 | `git checkout main && git pull && git checkout -b issue-N-slug` | Always pull before branching |
| 3 | Write failing tests → implement → all green | **No green = stop** |
| 4 | Update `./docs/` if API/behaviour changed | Required |
| 5 | Commit with `Closes #N` | — |
| 6 | `gh pr create --base main` — no auto-merge, no branch rule bypass | PR linked to issue |
| 7 | Report to user, pause | **Wait for "continue"** |
| 8 | `git checkout main && git pull` → back to Step 1 | — |

**Absolute hard stops — do none of these ever:**
- Auto-merge or pass `--merge` to any PR command
- Target a base branch other than `main` without explicit user confirmation
- Bypass or override branch protection rules
- Pick up an issue that already has an open PR
- Start any issue from phase N+1 while phase N still has open issues without a PR
- Start work on any issue without explicit user approval
- Branch off a stale local `main` — always `git pull` immediately before branching

---

## Reference Files

- `references/docs-guide.md` — Developer docs structure, style, and what to document
- `references/pr-templates.md` — Expanded PR body templates for different change types
