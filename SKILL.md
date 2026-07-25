---
name: memory-vault
description: >-
  Persistent knowledge vault — Obsidian-compatible markdown with wiki-links, tags, and maps of content.
  Use when the user wants to remember something (a bug fix, decision, feature, learning, or pattern),
  recall or search past entries, review recent work, or when another skill produces knowledge worth preserving.
trigger: /memory
---

All entries live in `~/.memory_vault/` as an Obsidian-ready vault. On every invocation, check if `~/.memory_vault/entries/` exists. If not, run this skill's `scripts/init-vault.sh` to create the full vault structure before proceeding.

Three concepts anchor every operation:

- **Entry** — one markdown file capturing one discrete piece of knowledge.
- **Thread** — a chain of entries connected by `[[wiki-links]]`. Threads are what make the vault a graph, not a pile.
- **Map** — a Map of Content (MOC) file that indexes entries by type or topic.

## Remember

Create a new **entry**.

1. **Classify.** Determine the entry type from context: `bug`, `decision`, `feature`, `learning`, or `snippet`. If ambiguous, ask the user.

2. **Thread.** Identify every concept worth linking: project names, technologies, libraries, patterns, related past entries. Each becomes a `[[wiki-link]]` in kebab-case. Err toward more links — orphan entries are invisible in the graph. Search the vault (`grep -rli` across `~/.memory_vault/entries/`) for existing mentions of the same concepts; if related entries exist, add backlinks in both directions.

3. **Write.** Create the entry at `~/.memory_vault/entries/YYYY-MM-DD-slug.md` using the template for its type (see [FORMAT.md](references/FORMAT.md)). Slug is lowercase-kebab-case, max 6 words. Completion: file exists, frontmatter is valid YAML, every identified concept has a wiki-link in the body.

4. **Index.** Append a link line to:
   - The type's **map** at `~/.memory_vault/maps/{type}s.md` under `## Recent`
   - Today's daily note at `~/.memory_vault/daily/YYYY-MM-DD.md` (create from daily template if missing — see [FORMAT.md](references/FORMAT.md))

   Completion: both files contain a line linking to the new entry.

After indexing, confirm to the user: entry path, type, and thread count (number of wiki-links created).

## Recall

Search the vault and present matching **entries**.

1. **Search.** Parse the user's query into key terms. Search across `~/.memory_vault/entries/` using `grep -rli` for content matches, and `grep -l` in frontmatter for tag/type matches. Also check relevant **maps** for quick category hits. Present matches as clickable file links with title, date, type, and first-line summary.

2. **Follow threads.** If the user wants deeper context, or fewer than 3 results were found, read the matched entries and follow their `[[wiki-links]]` one hop outward. Present the expanded thread as a chain showing how entries connect.

Completion: every matching entry presented with file links, or "no entries match" stated explicitly. If the vault is empty, say so.

## Review

Show recent activity in the vault.

1. **List recent.** Read today's daily note (and the previous 6 days if it exists). Present entries chronologically with file links, type badges, and one-line summaries.

2. **Stats.** Count total entries, entries per type, and total unique wiki-link targets. Present as a compact summary.

Completion: recent entries listed, or "vault is empty" stated.

## Threading rules

These rules apply to every **remember** operation:

- Link **projects** (`[[project-name]]`), **technologies** (`[[react]]`, `[[postgres]]`), **patterns** (`[[retry-with-backoff]]`), and **past entries** by slug (`[[2024-01-15-fix-auth-bug]]`).
- Always lowercase-kebab-case for wiki-link targets — consistency is what makes Obsidian's graph view useful.
- When an entry references a concept that has no existing entry, still create the wiki-link. Obsidian shows these as unresolved links, which surfaces knowledge gaps.
- Tags in frontmatter use the `#category/subcategory` nesting convention (e.g., `#lang/typescript`, `#infra/docker`).
