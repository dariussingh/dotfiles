# Line Resolution Reference

How to reliably find the right line number for a GitHub inline PR comment.

---

## How GitHub Inline Comments Work

GitHub requires:
- `path` — the file path relative to repo root (`src/auth/login.ts`, not `./src/auth/login.ts`)
- `line` — the **right-side** line number in the unified diff (the `+` side)
- `side` — always `"RIGHT"` when commenting on new/changed code

GitHub will reject the API call if the line is not part of the PR diff. This is the most common failure.

---

## Reading the Diff

```bash
gh pr diff <PR-number>
```

Output looks like:

```
diff --git a/src/auth/login.ts b/src/auth/login.ts
index abc123..def456 100644
--- a/src/auth/login.ts
+++ b/src/auth/login.ts
@@ -38,7 +38,12 @@ export async function login(req, res) {
   const user = await db.findUser(req.body.email);
+  if (!user) return res.status(404).json({ error: 'Not found' });
   const token = sign({ id: user.id });
```

The `@@ -38,7 +38,12 @@` hunk header means:
- Old file: starts at line 38, spans 7 lines
- New file: starts at line 38, spans 12 lines

Count `+` and context lines from the hunk start to get the right-side line number:
- Context lines (no prefix) advance both sides
- `+` lines advance only the right side
- `-` lines advance only the left side

---

## When the Line Is Not in the Diff

A finding may point to code that exists in the file but wasn't changed in this PR. Options:

1. **Find the nearest changed line** — if the unchanged line is within 3 lines of a `+` or `-` line, use that adjacent changed line and note in the comment body: "Issue is at line N, commenting on nearest changed line."

2. **Post as a file-level comment** — use `gh pr comment` without `--line`. In the comment body, open with:
   `📍 **File:** \`<path>\` · **Line ~N** (not in diff)`

3. **Post as a general PR comment** — if the file itself isn't in the diff at all (e.g. the issue is in an imported module), post a general comment with the full path and line reference.

---

## Renamed or Moved Files

If a file was renamed in the PR:

```
diff --git a/old/path/file.ts b/new/path/file.ts
similarity index 95%
rename from old/path/file.ts
rename to new/path/file.ts
```

Always use the **new** path (`b/` side) as the `path` parameter.

---

## Multi-File Findings

Architecture findings sometimes span multiple files (e.g. a circular dependency between `A.ts` and `B.ts`).

- Post **one comment per file** involved, each referencing the relevant import/export line.
- In each comment, note: "Related to the comment on `<other-file>`."

---

## Getting the Commit ID

The `commit_id` must be the HEAD commit of the PR branch, not the merge base:

```bash
gh pr view <PR-number> --json headRefOid -q .headRefOid
```

Cache this value and reuse it for all inline comments in the same session — it doesn't change unless someone pushes a new commit to the branch mid-session.

---

## Resolving {owner}/{repo}

```bash
gh repo view --json owner,name -q '"\(.owner.login)/\(.name)"'
```

Use this value literally in API calls: `repos/<owner>/<repo>/pulls/...`

---

## Quick Diagnostic

If a comment POST returns a 422 error:

```bash
gh api repos/{owner}/{repo}/pulls/<PR>/comments \
  --method POST \
  --field body="test" \
  --field commit_id="<sha>" \
  --field path="<path>" \
  --field line=<N> \
  --field side="RIGHT" \
  2>&1
```

Common causes of 422:
- Line number not in the diff → use file-level fallback
- `path` has a leading `./` → remove it
- `commit_id` is the merge base instead of head → re-fetch with `headRefOid`
- Side is wrong → use `"RIGHT"` for new code, `"LEFT"` for deleted code
