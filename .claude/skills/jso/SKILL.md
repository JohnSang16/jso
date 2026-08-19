---
name: jso
description: Terminal-native orchestrator for parallel Claude Code work. Notices when a task deserves its own git worktree and Ghostty split, asks permission first, and runs a tiered diff review (high-level/in-depth/minimal) with merge/edit/discard when the work is done.
---

# JSO (John Sang's Orchestrator)

Scope contract: `personal/personal-projects/jso.md` in the vault. If something
here conflicts with that doc, the doc wins, don't relitigate scope inline.

## When to propose a worktree

Propose spawning a worktree when a task is genuinely independent and
substantial: a separate feature, a parallel investigation, a risky refactor
you'd want isolated from your current branch. Don't propose it for small
edits, quick fixes, or anything that finishes in one or two tool calls.

**Always ask first, in chat, before running anything.** Say what the task is
and what branch name you'd use. Wait for an explicit yes. Never spawn a
worktree silently, that's the one thing this project is deliberately built to
not do (unlike Claude Code's native Agent Teams, which spawns without asking).

## Spawning (on approval)

1. Check `~/.jso/home-terminal-id` exists. If not, tell the user to run
   `scripts/register-home.sh` from the pane they're working in, then stop and
   wait, don't guess which pane is home.
2. Run `scripts/spawn-worktree.sh <branch-name>` from inside the target repo.
   This creates the worktree + branch and opens Claude Code in a new Ghostty
   split.
3. Tell the user the branch name and worktree path so they can find it later.

## Diff review (when the worktree's work is done)

Trigger this when the user says the parallel task is finished, or asks to
review it.

1. Run `scripts/diff-worktree.sh <branch> [base]` (base defaults to `main`).
2. Default to **high-level**: read the diff yourself and write a short bullet
   summary of what changed, plus a one-line risk assessment (low/medium/high,
   and why). Don't paste the raw diff at this level.
3. Always show this footer under whichever view is active:
   ```
   view: [1] high-level  [2] in-depth  [3] minimal
   [m]erge   [e]dit   [d]iscard
   ```
4. If the user types `2`, show the actual diff output from the `full diff`
   section verbatim. If they type `3`, show only the stat line plus a
   high-impact flag if one applies, nothing else. Re-show the footer every
   time.
5. On `m`, run `scripts/merge-worktree.sh <branch> [base]`. Confirm the merge
   commit and that the worktree was cleaned up.
6. On `e`, tell the user the worktree path so they can edit it directly (in
   the split pane or their editor), don't take further action yourself.
7. On `d`, discard: run
   `git -C <repo-root> worktree remove <worktree-path> --force && git -C <repo-root> branch -D <branch>`.
   Confirm before running this, discard is destructive.

## Everything else

Test-gate automation, `/pr-writer` fold-in, and a self-healing debug agent are
explicitly out of scope for this version, see the scope doc. Don't build
toward them here even if a task seems to invite it.
