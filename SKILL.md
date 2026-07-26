---
name: mentat
description: >-
  Persistent knowledge and general memory vault — Obsidian-compatible markdown with wiki-links, tags, and maps of content.
  Use when the user wants to remember anything (a note, idea, journal, bug fix, decision, feature, learning, or pattern),
  recall or search past entries, review recent work, or export their memory.
trigger: 
  - /mentat
  - /brain
---

All entries live in `~/.mentat/` as an Obsidian-ready vault. On every invocation, check if `~/.mentat/entries/` exists. If not, run this skill's `scripts/init-vault.sh` to create the full vault structure before proceeding.

Three concepts anchor every operation:

- **Entry** — one markdown file capturing one discrete piece of knowledge.
- **Thread** — a chain of entries connected by `[[wiki-links]]`. Threads are what make the vault a graph, not a pile.
- **Map** — a Map of Content (MOC) file that indexes entries by type or topic.

## Remember

Create a new **entry**.

1. **Curate (Validity Gate).** Evaluate if the information is trivial, obvious, or irrelevant long-term. If it is, stop and tell the user you think it's trivial. If the user explicitly insists, proceed anyway.
2. **Classify.** Determine the entry type from context: `note`, `idea`, `journal`, `bug`, `decision`, `feature`, `learning`, `snippet`, `episodic`, or `schema`.
3. **Thread.** Identify every concept worth linking: people, projects, technologies, ideas, related past entries. Each becomes a `[[wiki-link]]` in kebab-case. Err toward more links — orphan entries are invisible in the graph. Search the vault (`grep -rli` across `~/.mentat/entries/`) for existing mentions of the same concepts; if related entries exist, add backlinks in both directions.
4. **Write.** Create the entry at `~/.mentat/entries/YYYY-MM-DD-slug.md` using the template for its type (see [FORMAT.md](references/FORMAT.md)). Slug is lowercase-kebab-case, max 6 words. **Use atomic bullets** instead of long paragraphs. Completion: file exists, frontmatter has `salience: 100` and `usage_count: 0`.
5. **Index.** Append a link line to the type's map and today's daily note.

## Recall

Search the vault and present matching **entries**.

1. **Search.** Parse the user's query into key terms. Search across `~/.mentat/entries/` and **maps**. Present matches as clickable file links.
2. **Follow threads.** If the user wants deeper context, read the matched entries and follow their `[[wiki-links]]` one hop outward.
3. **Reconsolidate.** For every entry you read that proved useful in answering the user, edit its file to increment `usage_count` by 1 and `salience` by 10. This makes useful memories stronger over time.

## Load

Load the core memory to establish high-level context.

1. **Read.** Read `~/.mentat/core-memory.md`. If it doesn't exist or is empty, ask the user what the current Intent Anchor should be.
2. **Adopt.** Use this core memory to anchor your current session. Do not load this automatically unless invoked by the user (e.g. `/mentat load`).

## Consolidate

Create a Schema from scattered knowledge.

1. **Analyze.** Find related entries across the vault that share a common pattern.
2. **Synthesize.** Create a new `schema` entry that abstracts the patterns (e.g., "Standard Auth Flow"). Link the source entries in the `related` frontmatter.

## Groom

Maintain vault health by decaying old memories.

1. **Decay.** Reduce `salience` of older entries. If an entry hasn't been used and `salience` drops below 10, move it to `~/.mentat/archive/`.

## Export

Export the entire vault so the user can back it up or move it to another computer.

1. **Zip.** Run `zip -r ~/Desktop/mentat_export_$(date +%Y%m%d).zip ~/.mentat`
2. **Confirm.** Inform the user that the export was created on their Desktop.

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
