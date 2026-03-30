---
name: github-review-comments
description: >
  Use this skill to publish full-code-review findings from the current chat as GitHub PR inline comments.
  This skill does NOT perform any review — it only reads CRITICAL and HIGH findings already produced
  by the full-code-review skill earlier in the conversation and posts them to a PR. Triggers on:
  "post review comments to the PR", "add GitHub comments from the review", "create inline PR comments",
  "push the review findings to GitHub", "comment the review on the PR", "put the review on the PR".
  Always use this skill when the user wants to take full-code-review output from this chat and post it to
  a GitHub pull request — never do this ad-hoc.
---

# GitHub Review Comments Skill

Publishes CRITICAL and HIGH findings from the full-code-review already in this chat to a GitHub PR.
**This skill does zero reviewing.** It reads the chat, extracts findings, and posts them.


---

## Step 1 — Verify GitHub Access

```bash
gh auth status
gh pr view <PR-number>   # confirm PR exists and is open
gh repo view --json owner,name -q '"\(.owner.login)/\(.name)"'  # get owner/repo
```

If `gh` is not authenticated or the PR is not found, stop and tell the user.

---

## Step 2 — Extract Findings From the Chat

Scan the conversation above for output produced by the `full-code-review` skill. Collect every finding
marked **CRITICAL** or **HIGH** from any of these modes:

- Code Review findings table
- Architecture Review findings
- Document Code findings

**Skip MEDIUM and LOW entirely** — they stay in chat only.

For each CRITICAL/HIGH finding record:

| Field | Where to get it |
|---|---|
| `severity` | CRITICAL or HIGH, from the review output |
| `title` | The finding's short label from the review |
| `body` | The full description — what's wrong, why it matters, suggested fix |
| `file` | The file path mentioned in the finding (relative to repo root) |
| `line` | The line number mentioned in the finding |

If `file` or `line` is missing for a finding, resolve it using the diff (Step 3).

---

## Step 3 — Resolve Lines Against the PR Diff

GitHub only allows inline comments on lines present in the PR diff.

```bash
gh pr diff <PR-number>
```

For each finding:
1. Find its file in the diff (`+++ b/<path>` headers).
2. Locate the line within the diff hunk — use the **right-side (`+`) line number**.
3. If the line is **not in the diff**: post as a general PR comment instead (Step 5b), prefixing with `📍 \`<file>\` line ~<N> (not in diff)`.

Read `references/line-resolution.md` for renamed files, moved lines, and 422 errors.

---

## Step 4 — Post the Parent Summary Comment First

```bash
gh pr comment <PR-number> --body "## 🔍 Reviewed with OpenCode

CRITICAL and HIGH findings from the code review have been posted as inline comments on this PR.
```

---

## Step 5 — Post One Inline Comment Per Finding

**One comment per finding. Never bundle two issues into one comment.**

### 5a — Inline comment (line is in the diff)

```bash
COMMIT=$(gh pr view <PR-number> --json headRefOid -q .headRefOid)
OWNER_REPO=$(gh repo view --json owner,name -q '"\(.owner.login)/\(.name)"')

gh api repos/$OWNER_REPO/pulls/<PR-number>/comments \
  --method POST \
  --field body="<comment-body>" \
  --field commit_id="$COMMIT" \
  --field path="<relative/file/path>" \
  --field line=<line-number> \
  --field side="RIGHT"
```

### 5b — General comment (line not in diff)

```bash
gh pr comment <PR-number> --body "<comment-body>"
```

### Comment body format

```
**[SEVERITY] Title**

<Finding description verbatim from the review — what is wrong and where.>

**Why it matters:** <Impact from the review.>

**Fix:** <Suggested fix from the review.>
```

---

## Step 6 — Verify and Report

```bash
gh api repos/$OWNER_REPO/pulls/<PR-number>/comments \
  | jq '.[] | {path, line, body: .body[0:80]}'
```

Then report to the user:

```
✅ PR #<N> — Review comments posted

Parent comment : ✓ "Reviewed with open code"
Inline comments: <X> total (<Y> CRITICAL · <Z> HIGH)

Files:
  - <file> — <N> comment(s)

MEDIUM / LOW findings are in the chat review only.
```

---

## Edge Cases

| Situation | Action |
|---|---|
| Line not in diff | Post as general comment with `📍 file:line` prefix |
| `file` or `line` missing from finding | Check `gh pr diff` to locate the relevant hunk |
| No CRITICAL or HIGH findings in chat | Post only the parent comment noting no critical/high issues |
| Multiple sub-issues under one finding | Each sub-issue gets its own separate comment |
| `gh api` returns 422 | See `references/line-resolution.md` for diagnosis |
| Rate limited | Wait 60 s and retry — do not skip |

---

## Reference Files

- `references/line-resolution.md` — Resolving line numbers, renamed files, 422 errors
