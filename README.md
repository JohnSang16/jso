# jso (john sang's orchestrator)

an all-in-one claude orchestrator agent, inspired by claude conductor, not a
recreation of it. terminal-native: a claude code skill that notices when a
task deserves its own git worktree and ghostty split, asks before spawning
one, runs a gated test/debug loop, and shows a tiered diff review
(high-level / in-depth / minimal) with merge/edit/discard when the work is
done.

## architecture

```mermaid
flowchart TD
    A[task arrives] --> B{small or big?}
    B -->|small, 1-2 tool calls| C[build directly with lazysenior]
    B -->|big, needs real scope| D[invoke scope, ask if underspecified]
    D --> E[propose gameplan + branch name]
    E --> F{validated?}
    F -->|yes| G[spawn worktree + ghostty split]
    G --> H[build with lazysenior]
    C --> I[show diff]
    H --> I
    I --> J{confirmed?}
    J -->|yes| K[run tests]
    K --> L{pass?}
    L -->|no| M[ask, then jso-debugger fixes + retests]
    M --> K
    L -->|yes| N{small or big?}
    N -->|small| O[commit + push]
    N -->|big| P[draft pr: pr-writer or generic rubric]
    P --> Q{push approved?}
    Q -->|yes| R[push branch, open pr]
```

## a note on terminal support

the worktree-per-task idea is terminal-agnostic, but the actual split
mechanism today is not: it shells out to ghostty's own applescript
dictionary (macos only, needs ghostty >= 1.3.0). there's no equivalent
wired up for iterm2, kitty, windows terminal, or linux. tmux would be the
natural fallback (still terminal-native, just without the native ghostty
look), but that isn't built yet, this only runs on macos + ghostty right
now.

## install

the repo is both the plugin and its own self-hosted marketplace.

```
claude plugin marketplace add JohnSang16/jso
claude plugin install jso@jso-marketplace
```

restart claude code afterward for the skill and `jso-debugger` subagent to
register.

## update

the plugin cache is version-pinned, editing files here and pushing isn't
enough on its own:

```
claude plugin marketplace update jso-marketplace
claude plugin update jso@jso-marketplace
```

## layout

- `skills/jso/SKILL.md` - the orchestrator's judgment: task sizing, when to
  invoke scope, when to propose a worktree, the test/debug gate, diff
  review, pr drafting.
- `agents/jso-debugger.md` - gated subagent that fixes a failing test,
  never commits/merges/pushes on its own.
- `bin/` - the actual mechanics (`register-home.sh`, `new-split.sh`,
  `spawn-worktree.sh`, `diff-worktree.sh`, `merge-worktree.sh`), auto-added
  to `$PATH` when installed as a plugin.
