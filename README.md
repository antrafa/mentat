# Memory Vault

Persistent knowledge vault for AI coding agents. Stores bug fixes, decisions, features, learnings, and code patterns as Obsidian-compatible markdown with wiki-links, tags, and maps of content.

## What it does

When you work with an AI coding agent, knowledge gets lost between sessions — bugs you fixed, decisions you made, patterns you discovered. Memory Vault captures these as structured markdown entries connected by `[[wiki-links]]`, building a searchable knowledge graph over time.

**Three operations:**

| Command | What it does |
|---------|-------------|
| **Remember** | Creates a new entry from context — classifies it, threads wiki-links to related concepts, indexes in the appropriate map |
| **Recall** | Searches the vault by content, tags, or type — follows wiki-link threads for deeper context |
| **Review** | Shows recent activity — entries from the last 7 days with stats |

**Five entry types:**

| Type | When to use |
|------|-------------|
| `bug` | Bug fixed — symptoms, root cause, fix, lessons |
| `decision` | Technical/architectural decision — options, choice, rationale |
| `feature` | Feature built — approach, key files, caveats |
| `learning` | Something learned — insight, context, application |
| `snippet` | Reusable code pattern — when to use, code, notes |

## Vault structure

Everything lives in `~/.memory_vault/`, which opens directly as an Obsidian vault:

```
~/.memory_vault/
├── entries/          ← all entries (flat, connected by wiki-links)
├── maps/             ← Maps of Content by type (bugs.md, decisions.md, ...)
├── daily/            ← daily notes (chronological index)
└── index.md          ← vault dashboard
```

## Installation

### Gemini / Antigravity

```bash
# Clone the repo
git clone https://github.com/<your-user>/memory-vault.git

# Symlink into your skills directory
ln -s /path/to/memory-vault ~/.gemini/skills/memory-vault
```

### Claude Code

```bash
# Clone the repo
git clone https://github.com/<your-user>/memory-vault.git

# Add to your .claude/settings.json or project settings
```

### Manual initialization

The vault is created automatically on first use. To initialize manually:

```bash
bash /path/to/memory-vault/scripts/init-vault.sh
```

## Obsidian integration

After the vault is created, open it in Obsidian:

1. Open Obsidian
2. **File → Open vault**
3. Select `~/.memory_vault/`

You get for free:
- **Graph View** — visualize how entries connect through wiki-links
- **Backlinks** — see every entry that references the current one
- **Search** — full-text search across all entries
- **Unresolved links** — discover knowledge gaps (concepts referenced but not yet documented)
- **Tags** — filter by `#lang/typescript`, `#domain/auth`, etc.

## How threading works

Every entry links to related concepts using `[[wiki-links]]`:

```markdown
## Causa raiz

O token de refresh do [[oauth2]] expirava silenciosamente porque o
[[redis]] TTL estava configurado para 1h em vez de 24h no projeto [[my-api]].
```

This creates edges in Obsidian's graph. Over time, clusters emerge — you can see which technologies cause the most bugs, which projects share patterns, and how decisions connect to features.

The agent also adds **backlinks**: when a new entry references a concept that appears in existing entries, it links them in both directions.

## File structure

```
memory-vault/
├── SKILL.md               ← agent instructions
├── references/
│   └── FORMAT.md           ← entry templates and conventions
├── scripts/
│   └── init-vault.sh       ← vault initialization (idempotent)
└── README.md               ← this file
```

## License

MIT
