# Vault Maintenance Operations

These operations are invoked via `/mentat {operation}`. For core operations (Remember, Recall, Load, Review, Amend), see [SKILL.md](../SKILL.md).

## Consolidate

Create a Schema from scattered knowledge.

1. **Analyze.** Find clusters of 3+ entries that share at least 2 common wiki-links or tags. Present the candidate cluster to the user for approval before creating the schema.
2. **Synthesize.** Create a new `schema` entry that abstracts the patterns (e.g., "Standard Auth Flow"). Link the source entries in the `related` frontmatter.

Completion: schema entry created with `salience: 200`. Source entries listed in `related` field.

## Groom

Maintain vault health by **fading** old memories.

1. **Fade.** For each fadeable entry (`note`, `idea`, `journal`, `episodic`), compute days since `last_accessed` in frontmatter (fall back to `date` if `last_accessed` is absent). Apply exponential decay: `new_salience = floor(current_salience × 0.98 ^ days_since_last_access)`. Minimum salience is 0. **Never fade or archive** entries of type `bug`, `decision`, `learning`, `schema`, `snippet`, or `feature` — these are permanent knowledge.
2. **Archive.** If a fadeable entry has `salience ≤ 10`, move it to `~/.mentat/archive/` and remove its line from the type MOC and daily note. Keep the file intact for potential recovery.

> **Recommended cadence:** Run groom weekly, or whenever the vault exceeds 100 entries. During Review, suggest groom to the user if fadeable entries exceed 30.

Completion: every fadeable entry visited and salience recalculated. All entries with salience ≤ 10 archived and removed from MOCs.

## Export

Export the entire vault for backup.

1. **Zip.** Run `zip -r ~/Desktop/mentat_export_$(date +%Y%m%d).zip ~/.mentat -x "*.DS_Store" -x "__MACOSX/*"`. If `~/Desktop` does not exist, export to `~/` instead.
2. **Confirm.** Inform the user that the export was created.

Completion: zip file created and user informed of location.

## Import

Restore a vault from a previously exported backup.

1. **Locate.** Ask the user for the path to the `.zip` file (or detect `~/Desktop/mentat_export_*.zip` files and present them as options).
2. **Validate.** Unzip to a temporary location. Verify the archive contains the expected structure (`entries/`, `maps/`, `daily/`, `core-memory.md`). If invalid, abort and inform the user.
3. **Strategy.** Ask the user whether to **replace** the current vault entirely or **merge** (import only entries that don't already exist by slug).
4. **Apply.** Execute the chosen strategy. For merge mode, skip entries with duplicate slugs and report which were skipped.
5. **Audit.** Run the Audit operation automatically after import.

Completion: vault restored from backup. Audit run and results presented.

## Forget

Permanently delete an entry by user request.

1. **Confirm.** Show the entry title, type, and creation date. Ask the user to confirm deletion.
2. **Unlink.** Remove backlinks referencing this entry from all related entries. Remove the entry's line from its type MOC and daily note.
3. **Delete.** Remove the file from `entries/` (or `archive/` if already archived).

Completion: entry file deleted. All backlinks, MOC lines, and daily note references removed.

## Merge

Combine two redundant or complementary entries into one.

1. **Identify.** The user provides two entries (by slug, title, or query). Read both entries fully.
2. **Confirm.** Show both entries side-by-side (titles, types, dates, summaries). Ask the user which should be the **target** (survivor) and which the **source** (absorbed). If types differ, ask which type the merged entry should have.
3. **Combine.** Merge the source's content into the target using atomic bullets. Union the `tags`, `related`, and wiki-links from both entries. Set `usage_count` to the sum of both. Set `salience` to the higher of the two values.
4. **Relink.** Update all entries and MOCs that referenced the source to point to the target instead.
5. **Delete source.** Remove the source file and its lines from MOCs and daily notes.

Completion: source file deleted. Target updated with merged content. All references across entries and MOCs point to target.

## Split

Divide an entry that covers multiple distinct topics into separate atomic entries.

1. **Analyze.** Read the entry. Identify the distinct topics or concepts it covers. Present the proposed split to the user for approval.
2. **Create.** For each distinct topic, create a new entry with the appropriate type, inheriting the original's `tags`, `project`, and `date`. Each new entry gets `salience: 100` and `usage_count: 0`. Cross-link the new entries in their `related` fields.
3. **Relink.** Update all entries that referenced the original to point to the most relevant new entry. Update MOCs and daily notes.
4. **Archive original.** Move the original entry to `~/.mentat/archive/` with a note indicating it was split, linking to the new entries.

Completion: new entries created for each topic. Original archived with split note. All references updated to point to new entries.

## Audit

Validate vault integrity and report health issues.

1. **Orphan entries.** List entries in `~/.mentat/entries/` that do not appear in any MOC (`~/.mentat/maps/*.md`).
2. **Broken MOC references.** List MOC lines that reference entries not found in `entries/` or `archive/`.
3. **Broken wiki-links.** Scan all entries for `[[wiki-links]]` that point to entry slugs (date-prefixed) where the target file no longer exists.
4. **Stale daily notes.** List daily notes that reference entries no longer in `entries/`.
5. **Report.** Present findings as a summary table with counts and file links. Offer to auto-fix what can be fixed (remove broken MOC lines, add orphan entries to their type MOC).

> **Recommended cadence:** Run audit alongside groom, or after any bulk delete/archive operation.

Completion: all 5 checks executed. Summary table with counts and file links presented.
