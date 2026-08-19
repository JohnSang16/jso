# PR templates

Reference for the PR-drafting step in `SKILL.md`. Load this file once a PR
actually needs drafting, it isn't part of the main skill body.

Grounded in a real read of merged PRs across multiple repos (feat, fix,
refactor, copy, test, spike), not invented categories. Most diff *types*
converge on the same shape, only a few genuinely diverge.

## Step 1: pick a base shape

**Terse** — tiny, single-cause change (roughly under ~80 lines, 1-2 files),
any type label. No headers, no checkboxes, plain paragraphs, this order:
what broke/changed → the actual mechanism → how it was tested.

**Structured-default** — the shared workhorse. Covers feat, fix, refactor,
copy, and test-only changes alike, they don't need separate templates:
```
## Summary
- one bullet per distinct change, ordered by importance, not chronology
- an unrelated drive-by fix gets its own labeled bullet, never buried

## Test plan
- [x] checkbox per thing verified, cite the actual command/output
- [ ] leave unchecked and visible anything not yet verified
```

**Root-cause** — use instead of structured-default when the change *is* a
bug fix and the "why it was wrong" story is itself worth telling, not just
what changed but what was actually broken and why:
```
## Description
one line: what's wrong, plain, no ceremony

## What was wrong
the actual mechanism, root cause not symptom

## What changed
bullets, the fix itself

## Results / Test plan
numbers, not adjectives
```

**Experimental / spike** — use when multiple approaches were actually tried
and measured, not just implemented once:
```
## Summary
## What's here / What changed
## Key result
a comparison table: variant, mechanism, the metrics that mattered

## Why the other variants were rejected
real numbers per rejected option, not vibes

## Test plan
```

**Feature-with-gaps** — layer this on top of structured-default or
root-cause when the change is real and tested but not fully shippable yet
(a real environment/access blocker, not a todo):
```
(base shape above, plus:)
## Blockers before this can go live
numbered, most specific/actionable first
```
or, for an infra/deploy-specific gap instead of a hard blocker:
```
## Deploy note
what the next environment needs that isn't automated yet
```

## Step 2: layer on the target repo's own ceremony

Check the target repo's actual PR template and its 2-3 most recent merged
PR bodies (`gh pr list --repo <owner/repo> --state merged --limit 3 --json
body`). Some repos add a real extra layer on top of whichever base shape
above applies, it's not a replacement for it:
```
## Rollback plan
how to revert, and what it does/doesn't affect

Related issue: <link>
<ticket-system>: <id>
```
This is repo convention, not a diff-type thing. Apply it regardless of
which base shape was picked in Step 1.

## Step 3: deduce, don't force a single label

A real change is often more than one type at once, a feature that also
fixes an unrelated bug found while testing it, a refactor that's also
experimental. When that happens: pick the base shape that matches the
*dominant* story, and fold the secondary thing in as its own labeled bullet
or section instead of forcing two full templates together. Example:
"**Also fixed, unrelated bug caught while testing this:** ..." as its own
bullet inside an otherwise plain structured-default Summary.

## Step 4: voice, regardless of shape

- Root cause, never symptom, name the actual mechanism.
- Numbers over adjectives ("182/182 passing", not "most tests pass").
- Name what's *not* done, explicitly, never hide a gap by omitting it.
- Declarative, not first-person ("Removes the old guard...", not "I
  removed...").
- If an alternative was tried and rejected, say so with real numbers, not
  vibes.
- Cite the source of truth when a choice mirrors an external doc or spec.
- No em dashes, no dashes in prose, no emoji.

## Step 5: title

Match the target repo's own recent convention (Conventional Commits, a
ticket-ID scope, plain imperative English, whatever its actual history
shows), don't force one style everywhere.
