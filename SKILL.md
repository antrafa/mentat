---
name: mentat
description: >-
  Persistent knowledge vault. Use when the user wants to remember something,
  recall or search past entries, load project context, build or view their
  profile, review vault activity, check vault status, or amend an existing entry.
trigger: 
  - /mentat
---

The mentat vault lives at `~/.mentat/` as an Obsidian-ready knowledge store. On every invocation, check if `~/.mentat/entries/` exists. If not, run this skill's `scripts/init-vault.sh` to create the full vault structure before proceeding.

Three dynamics govern the vault:
- **Reconsolidate** — every use of an entry strengthens it (+10 salience, +1 usage_count, update `last_accessed` to today, capped at 500).
- **Fade** — unused transient entries decay exponentially and archive when salience ≤ 10 (see Groom in [OPERATIONS.md](references/OPERATIONS.md)).
- **Sieve** — recall runs a 4-layer filter (slug → frontmatter → content → MOC), stopping when results suffice.

For entry format templates, tagging conventions, and naming rules, always consult [FORMAT.md](references/FORMAT.md).

For vault maintenance operations (Groom, Audit, Merge, Split, Forget, Export, Import, Consolidate), see [OPERATIONS.md](references/OPERATIONS.md).

## Remember

Create a new entry.

1. **Curate (Validity Gate).** Evaluate if the information is trivial, obvious, or irrelevant long-term. If it is, stop and tell the user you think it's trivial. If the user explicitly insists, proceed anyway.
2. **Classify.** Determine the entry type from context: `note`, `idea`, `journal`, `bug`, `decision`, `feature`, `learning`, `snippet`, `episodic`, or `schema`.
3. **Thread.** Identify every concept worth linking: people, projects, technologies, ideas, related past entries. Each becomes a `[[wiki-link]]` in kebab-case. Err toward more links — even if the target doesn't exist yet (surfaces knowledge gaps). Search the vault (`grep -rli` across `~/.mentat/entries/`) for existing mentions of the same concepts; if related entries exist, add backlinks in both directions.
4. **Deduplicate.** Before creating, search for existing entries with similar slugs or overlapping wiki-links. If a strong match exists, ask the user whether to amend the existing entry or create a new one.
5. **Write.** Create the entry at `~/.mentat/entries/YYYY-MM-DD-slug.md` using the template for its type (see [FORMAT.md](references/FORMAT.md)). **Use atomic bullets** instead of long paragraphs. 
6. **Index.** Append a link line to the type's MOC at `~/.mentat/maps/{type}s.md`, today's daily note at `~/.mentat/daily/YYYY-MM-DD.md`, and the "Entradas recentes" section of `~/.mentat/index.md` (keep only the 10 most recent).

Completion: dedup check done, file exists with `salience: 100` (`200` for schema) and `usage_count: 0`, backlinks added in both directions, and all MOCs/indexes updated.

## Recall

Search the vault and present matching entries.

1. **Sieve.** Parse the user's query into key terms and likely synonyms. Execute the following layers in order, stopping when sufficient results are found:
   - **Layer 1 — Slug match:** `ls ~/.mentat/entries/ | grep -i` on key terms. Fast, exact.
   - **Layer 2 — Frontmatter match:** `grep -rli` targeting `tags:`, `project:`, and `related:` fields in `~/.mentat/entries/`.
   - **Layer 3 — Content match:** `grep -rli` across full file content in `~/.mentat/entries/` and `~/.mentat/maps/`.
   - **Layer 4 — MOC scan:** If previous layers yield fewer than 3 results, read the relevant MOC files and scan their one-line summaries for semantic matches.
   Present all matches as clickable file links, sorted by `salience` (highest first).
2. **Follow threads.** If the user wants deeper context, read the matched entries and follow their `[[wiki-links]]` one hop outward.
3. **Reconsolidate.** For every entry you read that proved useful in answering the user, edit its file to **reconsolidate** its salience.

Completion: At least one layer of the sieve executed. If results found, salience reconsolidated for every entry read.

## Load

Load the core memory to establish high-level context.

1. **Resolve.** If the user specifies a project name (e.g., `/mentat load myapp`), look for `~/.mentat/core-memory-{project}.md`. If no project is specified, use `~/.mentat/core-memory.md` (the global core memory). If neither file exists, ask the user what the current Intent Anchor should be and create the appropriate file.
2. **Read.** Read the resolved core memory file.
3. **Adopt.** Use this core memory to anchor your current session. Do not load this automatically unless invoked by the user (e.g., `/mentat load` or `/mentat load {project}`).

Completion: Core memory file read and its intent/rules adopted as context for the session.

## Profile

Build and maintain the user's identity so the mentat can personalize its work.

1. **Resolve.** Check if `~/.mentat/profile.md` exists.
   - **Exists:** read it, present the current profile summary, and ask what the user wants to update. Apply changes and skip to step 4.
   - **Missing:** proceed to step 2.
2. **Interview.** Ask the user about themselves — name, role, primary tech stack, preferred communication language, and any working preferences they want the mentat to respect. Keep it conversational, not a questionnaire. Start with identity basics; offer to go deeper on stack and preferences.
3. **Write.** Create `~/.mentat/profile.md` using the profile template (see [FORMAT.md](references/FORMAT.md)). Link technologies and tools as `[[wiki-links]]`.
4. **Thread.** Add backlinks from relevant core-memory files if they reference the same projects or tools.

Completion: `~/.mentat/profile.md` exists with at least name and preferred language filled. User confirmed accuracy.

## Review

Show recent activity in the vault.

1. **List recent.** Accept an optional number of days (default: 7). Read today's daily note and the previous N-1 days. Present entries chronologically with file links, type badges, and one-line summaries.
2. **Stats.** Count total entries, entries per type, and total unique wiki-link targets. Present as a compact summary.

Completion: recent entries listed (or "vault is empty" stated). Stats printed: total entries, entries per type, unique wiki-link targets.

## Status

Quick health dashboard of the vault.

1. **Scan.** Count: total entries in `~/.mentat/entries/`, entries per type (from frontmatter), entries in `~/.mentat/archive/`, total unique `[[wiki-link]]` targets across all entries, and unresolved wiki-links (date-prefixed links pointing to entries that no longer exist).
2. **Health.** Count fadeable entries (`note`, `idea`, `journal`, `episodic`) with `salience ≤ 30` (approaching archive threshold). If more than 10, suggest running Groom. Count orphan entries (files in `entries/` not listed in any MOC under `~/.mentat/maps/`). If any found, suggest running Audit.
3. **Present.** Display as a compact table: vault path, total disk size (`du -sh ~/.mentat`), and all counts above. Use ⚠️ markers on any health warnings.

Completion: all counts computed and presented as a table. Groom/Audit suggested if thresholds exceeded.

## Amend

Update an existing entry with new information.

1. **Find.** Search for the entry by slug, title, or query terms.
2. **Edit.** Modify the content while preserving the original frontmatter metadata. **Reconsolidate** the entry to reflect its use.
3. **Re-thread.** Add any new `[[wiki-links]]` discovered from the updated content. Add backlinks in both directions.
4. **Re-index.** If the summary changed, update the one-line summary in the type's MOC at `~/.mentat/maps/{type}s.md` and the daily note.

Completion: file content updated, salience reconsolidated, and all new threads/indexes linked.
