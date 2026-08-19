---
name: scope
description: Interactive scoping interview to run before starting any substantial task, story, or project. Works through one-liner, who actually feels it, success criteria, definition of done, explicit out-of-scope, decisions made, biggest risk, and verified-vs-assumed, one section at a time, until every section has a real answer instead of a placeholder.
---

# scope

Fill this out before building anything substantial. The goal is to lock
success criteria and a definition of done up front, so the work moves
toward a fixed target instead of circling. If a section can't be filled in,
that's the signal the task isn't understood yet, not a reason to skip it.

## The template

```
## One-liner
[Problem] + [solution] in one sentence. If it can't be written in one
sentence, the scope isn't understood yet, that's the actual work to do
first, before any building starts.

## Who actually feels this
Not "the user." The specific role or person, and what decision or action
they take differently once this ships.

## Success criteria
What does "good" look like, ranked or weighted if there's more than one
axis. If someone will judge or review this, use their actual rubric, not a
guess at it.

## Definition of done
A checklist tied to a concrete, checkable artifact (a passing test, a
working demo path, a merged PR). Not "feature works."
- [ ]
- [ ]

## Explicitly out of scope
| Cut | Why |
|---|---|

## Decisions already made
| Decision | Reasoning |
|---|---|
(Once a decision has reasoning attached here, it's closed. Don't relitigate
it mid-session, point back at this table instead.)

## Biggest risk
One thing to watch, and the failure mode if it's missed. Timebox it if it's
a research/unknown risk: if not resolved by [time], fall back to [X] and
move on.

## Verified vs assumed
| Claim | Status |
|---|---|
```

## How to run the interview

Ask one section at a time, in the order above. Wait for a real answer before
moving on. If an answer is generic or a placeholder ("the user," "make it
good," "it'll be obvious"), push back once and ask for the specific version
rather than accepting it and moving on.

1. **One-liner.** "What's the problem, and what's the fix, in one sentence?"
   If it can't fit in one sentence, say so, help narrow it rather than
   writing a paragraph in its place.
2. **Who actually feels this.** "Who specifically hits this, and what do
   they do differently once it's fixed?" Reject "the user" as an answer.
3. **Success criteria.** "How does this actually get judged, a rubric, a
   ticket's acceptance criteria, an assignment spec?" Ask whether a real one
   already exists before inventing one.
4. **Definition of done.** "What's the concrete, checkable artifact that
   proves this is done?" Push for something checkable, not a feeling.
5. **Explicitly out of scope.** "What are you deliberately not doing, and
   why?" If nothing comes to mind, ask what's tempting to add that
   shouldn't be, most tasks have at least one.
6. **Decisions already made.** "What's already settled that shouldn't get
   re-argued later?" Pull in anything already decided earlier in the
   current conversation.
7. **Biggest risk.** "What's most likely to blow up the timeline, and what's
   the fallback if it does?" Attach a time box if it's a research unknown.
8. **Verified vs assumed.** "What have you actually confirmed, versus what
   are you assuming is true?"

## Rules behind the template

- **Write the one-liner before touching code.** If it takes more than a
  sentence, that's the actual work to do first, before any implementation.
- **Name the real buyer, not a generic user.** A vague "user" produces a
  vague definition of done.
- **Success criteria should be a rubric, not a feeling.** Score against the
  actual judging criteria or acceptance criteria, not an assumption of what
  it probably means.
- **Cut scope by removing a whole dimension, not by half-supporting it.**
  When a feature is ambiguous or low-value, remove it completely rather than
  build a half version that has to be defended later.
- **Decisions get written down once, with reasoning, and then are closed.**
  If a session starts re-litigating something already decided, that's a
  signal the decision table wasn't checked first, not that the decision was
  wrong.
- **Timebox unknowns instead of letting them expand.** Set the cap before
  starting the research, not after it's already run long.
- **Check claims against evidence before repeating them**, and log it when a
  claim turns out wrong, don't quietly fix it and move on.

## Using this once filled

Show the completed template before writing anything to disk. File it
wherever this project keeps its scope docs, or ask if that's not obvious.
Point any later session that starts drifting back at this doc, that's the
signal a section here needs revisiting, not a prompt-engineering problem.
Once the definition of done checklist is checked, that's the exit condition,
don't keep polishing past it.
