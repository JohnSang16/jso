# JSO (John Sang's Orchestrator)

A terminal-native recreation of Claude Conductor: a Claude Code skill that
notices when a task deserves its own git worktree and Ghostty split, asks
before spawning one, runs a gated test/debug loop, and shows a tiered diff
review (high-level / in-depth / minimal) with merge/edit/discard when the
work is done.

## Install

The repo is both the plugin and its own self-hosted marketplace.

```
claude plugin marketplace add JohnSang16/jso
claude plugin install jso@jso-marketplace
```

Restart Claude Code afterward for the skill and `jso-debugger` subagent to
register.

## Update

The plugin cache is version-pinned, editing files here and pushing isn't
enough on its own:

```
claude plugin marketplace update jso-marketplace
claude plugin update jso@jso-marketplace
```

## Layout

- `skills/jso/SKILL.md` — the orchestrator's judgment: when to propose a
  worktree, how to spawn it, the test/debug gate, diff review, PR drafting.
- `agents/jso-debugger.md` — gated subagent that fixes a failing test,
  never commits/merges/pushes on its own.
- `bin/` — the actual mechanics (`register-home.sh`, `new-split.sh`,
  `spawn-worktree.sh`, `diff-worktree.sh`, `merge-worktree.sh`), auto-added
  to `$PATH` when installed as a plugin.

## Full scope and build log

`personal/personal-projects/jso.md` in John's vault is the standing scope
contract and running log for this project, definition of done, decisions
made and why, what's verified vs. just written.
