# Entry Format Reference

This file contains templates and conventions for every vault artifact. The agent loads this when writing entries.

## Frontmatter

Every entry starts with YAML frontmatter:

```yaml
---
type: note | idea | journal | bug | decision | feature | learning | snippet | episodic | schema
date: YYYY-MM-DD
tags: [tag1, tag2]
project: project-name
salience: 100
usage_count: 0
last_accessed: YYYY-MM-DD
status: open | resolved | superseded
related: ["[[entry-slug]]"]
---
```

## Core Memory

The vault supports one global core memory (`~/.mentat/core-memory.md`) and optional per-project core memories (`~/.mentat/core-memory-{project}.md`). Both use the same template (canonical source — `init-vault.sh` creates the initial file, but this template governs future edits). These are read on demand via the **Load** operation.

```markdown
# Core Memory & Intent

## Intent Anchor
{The current overarching objective or mission}

## Rules & Constraints
- {constraint 1}
- {constraint 2}

## World State
{brief summary of the current general context, max 500 words}
```

## User Profile

The file `~/.mentat/profile.md` stores persistent information about the user. Created via the **Profile** operation. One profile per vault.

```markdown
# Profile

## Identity
- **Name:** {name}
- **Role:** {role or profession}
- **Language:** {preferred communication language}

## Stack
- **Languages:** {programming languages, e.g. [[typescript]], [[python]]}
- **Frameworks:** {preferred frameworks, e.g. [[nextjs]], [[fastapi]]}
- **Tools:** {editors, CLI tools, OS}

## Preferences
- {working style notes, communication preferences, conventions to respect}
```

## Entry Templates

> **Atomic Bullets rule:** Mentat always prefers atomic bullets over long paragraphs. Distill information into direct, concise, actionable bullet points.

### Episodic

```markdown
---
type: episodic
date: {date}
tags: [{tags}]
project: {project}
salience: 100
usage_count: 0
last_accessed: {date}
status: resolved
related: []
---

# {title}

## Event

- **When:** {YYYY-MM-DD HH:MM}
- **Who:** {Claude / Codex / User}
- **Action:** {What was done atomically}

## Result
{Impact of the action}
```

### Schema

```markdown
---
type: schema
date: {date}
tags: [{tags}]
project: {project}
salience: 200
usage_count: 0
last_accessed: {date}
status: open
related: ["[[entry-1]]", "[[entry-2]]"]
---

# {title}

## Abstract Pattern
{The general rule or pattern derived from the related entries}

## Application
{How to apply this pattern in the future}
```

### Note

```markdown
---
type: note
date: {date}
tags: [{tags}]
project: {project}
salience: 100
usage_count: 0
last_accessed: {date}
status: open
related: []
---

# {title}

## Main Topics

{summary of the note's topics}

## Details

{body of the note}
```

### Idea

```markdown
---
type: idea
date: {date}
tags: [{tags}]
project: {project}
salience: 100
usage_count: 0
last_accessed: {date}
status: open
related: []
---

# {title}

## What it is

{quick description of the idea}

## Why it matters

{the value it brings or problem it solves}

## Next Steps

{what needs to happen to make it a reality}
```

### Journal

```markdown
---
type: journal
date: {date}
tags: [{tags}]
project: {project}
salience: 100
usage_count: 0
last_accessed: {date}
status: open
related: []
---

# {title}

## Daily Reflection

{what happened, thoughts, mental state}

## Highlights

- {item 1}

## Challenges

- {challenge 1}
```

### Bug

```markdown
---
type: bug
date: {date}
tags: [{tags}]
project: {project}
salience: 100
usage_count: 0
last_accessed: {date}
status: resolved
related: []
---

# {title}

## Symptoms

{what was observed — error, unexpected behavior}

## Root Cause

{why it happened}

## Fix

{what was changed to fix it}

## Changed Files

- `path/to/file.ext`

## Lessons Learned

{what to watch out for next time}
```

### Decision

```markdown
---
type: decision
date: {date}
tags: [{tags}]
project: {project}
salience: 100
usage_count: 0
last_accessed: {date}
status: open
related: []
---

# {title}

## Context

{situation that required the decision}

## Options Considered

1. **{option A}** — {pros and cons}
2. **{option B}** — {pros and cons}

## Decision

{which option was chosen}

## Rationale

{why this option and not the others}

## Consequences

{what changes from this decision — accepted tradeoffs}
```

### Feature

```markdown
---
type: feature
date: {date}
tags: [{tags}]
project: {project}
salience: 100
usage_count: 0
last_accessed: {date}
status: resolved
related: []
---

# {title}

## What was built

{description of what the feature does}

## Approach

{how it was implemented — architecture, patterns used}

## Key Files

- `path/to/file.ext` — {role of the file}

## Points of Attention

{edge cases, known limitations, technical debt}
```

### Learning

```markdown
---
type: learning
date: {date}
tags: [{tags}]
project: {project}
salience: 100
usage_count: 0
last_accessed: {date}
status: open
related: []
---

# {title}

## Insight

{what was learned — the core lesson in 1-2 sentences}

## Context

{how/where this knowledge emerged}

## Details

{deeper explanation, examples, references}

## Application

{when and how to use this knowledge in the future}
```

### Snippet

```markdown
---
type: snippet
date: {date}
tags: [{tags}]
project: {project}
salience: 100
usage_count: 0
last_accessed: {date}
status: open
related: []
---

# {title}

## When to use

{situation where this pattern applies}

## Code

\```{language}
{code}
\```

## Notes

{variations, caveats, alternatives}
```

## Map of Content (MOC)

Each type has a MOC at `~/.mentat/maps/{type}s.md`:

```markdown
# {Type}s

## Recent

- [[YYYY-MM-DD-slug]] — one-line summary

## By Project

### [[project-name]]

- [[YYYY-MM-DD-slug]] — one-line summary
```

When adding an entry, insert it in the `## Recent` section at the top. When a project accumulates 5+ entries in the Recent section, move them to a `### [[project-name]]` subsection under `## By Project`.

## Daily Note

Daily notes live at `~/.mentat/daily/YYYY-MM-DD.md`:

```markdown
# {YYYY-MM-DD}

## Entries

- [[YYYY-MM-DD-slug]] — summary ({type})
```

## Index

The `~/.mentat/index.md` file is the vault's dashboard:

```markdown
# Memory Vault

## Maps of Content

- [[notes]] — General notes and logs
- [[ideas]] — Loose ideas and future projects
- [[journals]] — Reflections and journals
- [[bugs]] — Fixed bugs and debug sessions
- [[decisions]] — Architecture and design decisions
- [[features]] — Built features
- [[learnings]] — Things learned
- [[snippets]] — Code patterns and recipes
- [[episodics]] — Recorded events and actions
- [[schemas]] — Synthesized abstract patterns

## Recent Entries

(last 10 entries linked here)
```

> **Maintenance rule:** Insert new links at the top of the "Recent Entries" section. If there are more than 10 entries, remove the oldest (last in the list) to keep the limit.

## Naming Conventions

| Element | Format | Example |
|---------|--------|---------|
| Entry file | `YYYY-MM-DD-slug.md` | `2024-03-15-fix-auth-token-refresh.md` |
| Slug | kebab-case, max 6 words | `fix-auth-token-refresh` |
| Wiki-link | `[[kebab-case]]` | `[[react]]`, `[[retry-with-backoff]]` |
| Tag | `#category/subcategory` | `#lang/typescript`, `#infra/docker` |

## Recommended Tags

Tag categories to maintain consistency:

- `#type/` — entry type, always include as the first tag (`#type/bug`, `#type/note`, `#type/schema`)
- `#lang/` — languages (`#lang/typescript`, `#lang/python`)
- `#framework/` — frameworks (`#framework/nextjs`, `#framework/fastapi`)
- `#infra/` — infrastructure (`#infra/docker`, `#infra/aws`)
- `#pattern/` — patterns (`#pattern/retry`, `#pattern/circuit-breaker`)
- `#domain/` — business domain (`#domain/auth`, `#domain/payments`)
- `#tool/` — tools (`#tool/git`, `#tool/obsidian`)
