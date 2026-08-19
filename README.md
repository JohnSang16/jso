# jso (john sang's orchestrator)

an all-in-one claude orchestrator agent, inspired by claude conductor, not a
recreation of it. terminal-native: a claude code skill that notices when a
task deserves its own git worktree and ghostty split, asks before spawning
one, runs a gated test/debug loop, and shows a tiered diff review
(high-level / in-depth / minimal) with merge/edit/discard when the work is
done.

## how it works, end to end

```
task
  -> claude deduces the size of the task
       small, a plain commit -> just do it and push
       big enough to need a pr -> invoke /scope, ask questions if there
                                   isn't enough context yet
  -> proposed gameplan
  -> validated by you
  -> implemented using /lazysenior methodology (minimal diff, no bloat)
  -> diffs shown
  -> confirmed by you
  -> tests run
  -> pr drafted and opened
```

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

- `skills/jso/SKILL.md` - the orchestrator's judgment: when to propose a
  worktree, how to spawn it, the test/debug gate, diff review, pr drafting.
- `agents/jso-debugger.md` - gated subagent that fixes a failing test,
  never commits/merges/pushes on its own.
- `bin/` - the actual mechanics (`register-home.sh`, `new-split.sh`,
  `spawn-worktree.sh`, `diff-worktree.sh`, `merge-worktree.sh`), auto-added
  to `$PATH` when installed as a plugin.
