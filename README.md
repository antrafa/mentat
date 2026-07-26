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
- **Core Memory Anchoring**: An on-demand intent anchor (`core-memory.md`) grounds the agent in your overarching objective.
- **Reconsolidation & Salience**: Memories grow stronger (`salience` increases) the more they are recalled and prove useful.
- **Permanent vs. Transient Memory**: 
  - Structural knowledge (`bug`, `decision`, `learning`, `schema`, `snippet`, `feature`) is **immortal**. It will never decay.
  - Transient knowledge (`note`, `idea`, `journal`, `episodic`) decays over time if unused and is eventually sent to the archive.
- **Schema Synthesis**: The agent can synthesize multiple scattered entries into unified, abstract pattern schemas.
- **Validity Gate**: The system actively refuses to store trivial or obvious information unless explicitly instructed.

## 📂 Vault Architecture

Everything is stored in a flat directory structure at `~/.mentat/` that opens natively as an **Obsidian** vault:

```text
~/.mentat/
├── core-memory.md    ← The overarching objective and world state
├── entries/          ← All atomic entries (flat, connected by [[wiki-links]])
├── maps/             ← Maps of Content by type (bugs.md, decisions.md, ...)
├── daily/            ← Daily notes (chronological index)
└── archive/          ← Forgotten/decayed transient memories
```

## 🚀 Installation

Mentat works with CLI-based AI agents like **Antigravity**, **Claude Code**, or **Codex**.

### 1. Clone & Link

```bash
# Clone the repository
git clone https://github.com/<your-user>/mentat.git

# Symlink into your agent's skills directory
ln -s /path/to/mentat ~/.agents/skills/mentat
```

### 2. Initialize the Vault

The vault is automatically created on the first invocation. To initialize it manually, run:

```bash
bash /path/to/mentat/scripts/init-vault.sh
```

## 🛠 Usage & Commands

Trigger the skill using the `/mentat` or `/brain` slash commands followed by your prompt.

| Command | Action | Description |
|---------|--------|-------------|
| `/mentat load` | **Load** | Reads `core-memory.md` to ground the agent in the current project context. |
| `/mentat [text]` | **Remember** | Curates the input via the Validity Gate. If valid, saves as an atomic entry, threads `[[wiki-links]]`, and sets base `salience: 100`. |
| `/mentat [query]` | **Recall** | Semantic search across the vault. Follows threads. Increments `salience` and `usage_count` for every useful entry found. |
| `/mentat consolide` | **Consolidate** | Analyzes scattered entries and synthesizes them into a unified **Schema**. |
| `/mentat groom` | **Groom** | Decays salience of unused transient entries. Archives those that drop below threshold. Permanent types are ignored. |
| `/mentat review` | **Review** | Displays recent vault activity from the last 7 days. |
| `/mentat export` | **Export** | Creates a `.zip` backup of the entire vault on your Desktop. |

### Examples

- **Remembering a fix:**  
  `> /mentat tivemos um bug de CORS hoje causado pelo Nginx, salve isso como bug.`
- **Contextualizing:**  
  `> /mentat load o contexto do projeto atual para conversarmos.`
- **Grooming the vault:**  
  `> /mentat groom`

## 🔮 Obsidian Integration

Mentat is designed to be a first-class citizen in [Obsidian](https://obsidian.md/).

1. Open Obsidian.
2. Select **Open folder as vault**.
3. Choose `~/.mentat/`.

**Native benefits you get for free:**
- **Graph View:** Visualize the clustering of your bugs, features, and technologies.
- **Backlinks:** See exactly what technologies or decisions caused specific issues.
- **Unresolved Links:** Discover knowledge gaps automatically.

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.
