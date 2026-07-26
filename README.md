# Mentat (Memory Vault)

> *"It is by will alone I set my mind in motion."*
> — Mentat Mantra (Dune)

In the *Dune* universe, after computers are banned, human **Mentats** are trained to possess supreme capabilities of computation, logic, and photographic memory. This skill acts as your personal Mentat — a persistent knowledge vault that never forgets.

It stores bug fixes, decisions, features, learnings, code patterns, ideas, and daily notes as Obsidian-compatible markdown with wiki-links, tags, and maps of content.

## What it does

When you work with an AI coding agent, knowledge gets lost between sessions. Mentat captures these as structured **atomic bullets** connected by `[[wiki-links]]`, building a searchable knowledge graph over time that learns and adapts.

Inspired by cognitive science and agent-memory research (like [Engram](https://github.com/softmaxdata/engram) and Mem-α), Mentat features:
- **Core Memory:** A persistent intent anchor loaded on demand.
- **Atomic Bullets:** Concise, trackable knowledge (no rambling paragraphs).
- **Reconsolidation & Salience:** Memories that are useful to you grow stronger (`salience` increases); unused ones decay and get archived.
- **Schemas:** The agent can synthesize multiple related entries into abstract patterns.
- **Validity Gate:** The agent will refuse to store trivial or obvious information unless you insist.

## Operations & Usage

You can invoke the skill using `/mentat` or `/brain`.

| Operation | Command Example | What it does |
|-----------|-----------------|--------------|
| **Load** | `/mentat load` | Reads `core-memory.md` to ground the agent in your current overarching objective. |
| **Remember** | `/mentat grave esse bug...` | Evaluates if the info is trivial. If valid, saves an entry using atomic bullets, threads wiki-links, and sets `salience: 100`. |
| **Recall** | `/mentat qual foi a decisão...` | Searches the vault by content or tags. Follows threads. For every useful entry, increments its `salience` and `usage_count` (Reconsolidation). |
| **Consolidate** | `/mentat consolide...` | Synthesizes multiple scattered entries into a unified **Schema** entry. |
| **Groom** | `/mentat groom` | Analyzes the vault, decays salience of unused memories, and archives those that drop below the threshold. |
| **Review** | `/mentat review` | Shows recent activity — entries from the last 7 days with stats. |
| **Export** | `/mentat export` | Zips your entire vault to your Desktop for backup. |

**Example Prompts:**
- *" /mentat tivemos um bug de CORS hoje causado pelo Nginx, salve isso."*
- *" /mentat load o contexto do projeto atual para conversarmos."*
- *" /mentat groom"*
- *" /mentat export"*

## Vault structure

Everything lives in `~/.mentat/`, which opens directly as an Obsidian vault:

```text
~/.mentat/
├── core-memory.md    ← The overarching objective and world state
├── entries/          ← All atomic entries (flat, connected by wiki-links)
├── maps/             ← Maps of Content by type (bugs.md, decisions.md, ...)
├── daily/            ← Daily notes (chronological index)
└── archive/          ← Forgotten/decayed memories
```

## Installation

### Any CLI Agent (Antigravity, Claude, Codex)

```bash
# Clone the repo
git clone https://github.com/<your-user>/mentat.git

# Symlink into your skills directory
ln -s /path/to/mentat ~/.agents/skills/mentat
```

### Manual initialization

The vault is created automatically on first use. To initialize manually:

```bash
bash /path/to/mentat/scripts/init-vault.sh
```

## Obsidian Integration

After the vault is created, open it in Obsidian:

1. Open Obsidian
2. **File → Open vault**
3. Select `~/.mentat/`

You get for free:
- **Graph View** — visualize how entries connect through wiki-links.
- **Backlinks** — see every entry that references the current one.
- **Search** — full-text search across all entries.

## How threading works

Every entry links to related concepts using `[[wiki-links]]`:

```markdown
## Causa raiz

O token de refresh do [[oauth2]] expirava silenciosamente porque o
[[redis]] TTL estava configurado para 1h em vez de 24h no projeto [[my-api]].
```

This creates edges in Obsidian's graph. Over time, clusters emerge — you can see which technologies cause the most bugs, which projects share patterns, and how decisions connect to features.

## License

MIT
