# Mentat (Memory Vault)

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Status](https://img.shields.io/badge/status-active-success.svg)
![Format](https://img.shields.io/badge/format-obsidian--ready-blueviolet)

> *"It is by will alone I set my mind in motion."* — Mentat Mantra (Dune)

**Mentat** is a persistent, graph-based knowledge vault designed for AI coding agents. It ensures that critical context, bug fixes, decisions, and patterns discovered during AI sessions are never lost between context windows.

Inspired by cognitive science and agent-memory research (such as Mem-α and Engram), Mentat stores knowledge not as unstructured text, but as **Atomic Bullets** linked together in a concept graph, allowing for true reconsolidation and learning over time.

---

## 🧠 Core Capabilities

- **Atomic Knowledge Base**: Information is strictly captured as concise, trackable bullets. No rambling paragraphs.
- **Core Memory Anchoring**: On-demand intent anchors (`core-memory.md` for global context, `core-memory-{project}.md` for project-specific context) ground the agent in your overarching objective.
- **User Profile**: A persistent `profile.md` stores who the user is — name, role, stack, preferences — so the mentat personalizes its work across sessions.
- **Reconsolidation & Salience**: Memories grow stronger (`salience` increases, `last_accessed` updates) the more they are recalled and prove useful.
- **Permanent vs. Transient Memory**: 
  - Structural knowledge (`bug`, `decision`, `learning`, `schema`, `snippet`, `feature`) is **immortal**. It will never decay.
  - Transient knowledge (`note`, `idea`, `journal`, `episodic`) decays based on time since last access and is eventually archived.
- **Schema Synthesis**: The agent can synthesize multiple scattered entries into unified, abstract pattern schemas.
- **Validity Gate**: The system actively refuses to store trivial or obvious information unless explicitly instructed.
- **Health Monitoring**: A dedicated status command reports vault health, warns about entries approaching archive threshold, and detects orphans.

## 📂 Vault Architecture

Everything is stored in a flat directory structure at `~/.mentat/` that opens natively as an **Obsidian** vault:

```text
~/.mentat/
├── .obsidian/                  ← Auto-generated Obsidian config (wiki-links, graph colors)
├── core-memory.md              ← Global intent anchor and world state
├── core-memory-{project}.md    ← Per-project intent anchors (optional)
├── profile.md                  ← User identity and preferences
├── index.md                    ← Vault dashboard with recent entries
├── entries/                    ← All atomic entries (flat, connected by [[wiki-links]])
├── maps/                       ← Maps of Content by type (bugs.md, decisions.md, ...)
├── daily/                      ← Daily notes (chronological index)
└── archive/                    ← Forgotten/decayed transient memories
```

## 🚀 Installation

Mentat works with CLI-based AI agents like **Antigravity**, **Claude Code**, or **Codex**.

### 1. Clone & Link

```bash
# Symlink into your agent's skills directory
ln -s /path/to/mentat ~/.agents/skills/mentat
```

### 2. Initialize the Vault

The vault is automatically created on the first invocation. To initialize it manually, run:

```bash
bash /path/to/mentat/scripts/init-vault.sh
```

## 🛠 Usage & Commands

Trigger the skill using the `/mentat` slash command followed by your prompt.

### Core Commands

| Command | Action | Description |
|---------|--------|-------------|
| `/mentat [text]` | **Remember** | Curates the input via the Validity Gate. If valid, saves as an atomic entry, threads `[[wiki-links]]`, dedup-checks, and sets base `salience: 100`. |
| `/mentat [query]` | **Recall** | Layered search across the vault (slug → frontmatter → content → MOC). Follows threads. Reconsolidates useful entries. |
| `/mentat load [project]` | **Load** | Reads `core-memory.md` (or `core-memory-{project}.md`) to ground the agent in context. |
| `/mentat profile` | **Profile** | Builds or views the user's identity profile. First time: conversational interview. After: shows current profile, allows updates. |
| `/mentat review [N]` | **Review** | Displays recent vault activity from the last N days (default: 7) with stats: total entries, entries per type, unique wiki-link targets. |
| `/mentat status` | **Status** | Quick health dashboard — entry counts, disk size, fade warnings, orphan detection. |
| `/mentat amend [query]` | **Amend** | Finds and updates an existing entry with new information. Reconsolidates salience. |

### Maintenance Commands

| Command | Action | Description |
|---------|--------|-------------|
| `/mentat consolidate` | **Consolidate** | Analyzes scattered entries and synthesizes them into a unified **Schema**. |
| `/mentat groom` | **Groom** | Applies exponential decay to transient entries based on time since last access. Archives those that drop below threshold. Permanent types are immune. |
| `/mentat audit` | **Audit** | Validates vault integrity: orphan entries, broken links, stale references. |
| `/mentat merge` | **Merge** | Combines two redundant entries into one, preserving all links and metadata. |
| `/mentat split [query]` | **Split** | Divides a multi-topic entry into separate atomic entries. |
| `/mentat forget [query]` | **Forget** | Permanently deletes an entry after confirmation. Cleans up all references. |
| `/mentat export` | **Export** | Creates a `.zip` backup of the entire vault on your Desktop. |
| `/mentat import [path]` | **Import** | Restores a vault from a previously exported `.zip` backup. Supports replace or merge strategies. |

### Examples

- **Remembering a fix:**  
  `> /mentat tivemos um bug de CORS hoje causado pelo Nginx, salve isso como bug.`
- **Loading context:**  
  `> /mentat load myapp`
- **Setting up your profile:**  
  `> /mentat profile`
- **Checking vault health:**  
  `> /mentat status`
- **Grooming the vault:**  
  `> /mentat groom`

## 🔮 Obsidian Integration

Mentat is designed to be a first-class citizen in [Obsidian](https://obsidian.md/).

1. Open Obsidian.
2. Select **Open folder as vault**.
3. Choose `~/.mentat/`.

**Native benefits you get for free:**
- **Graph View:** Visualize the clustering of your bugs, features, and technologies. Entries are auto-colored by type via `#type/` tags.
- **Backlinks:** See exactly what technologies or decisions caused specific issues.
- **Unresolved Links:** Discover knowledge gaps automatically.

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.
