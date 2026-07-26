#!/usr/bin/env bash
# Initializes the Mentat Vault directory structure at ~/.mentat
# Safe to run multiple times — skips if vault already exists.
set -euo pipefail

VAULT_DIR="${HOME}/.mentat"

if [[ -d "$VAULT_DIR/entries" ]]; then
  echo "✓ Vault already exists at $VAULT_DIR"
  exit 0
fi

echo "Creating Mentat Vault at $VAULT_DIR..."

mkdir -p "$VAULT_DIR"/{entries,maps,daily,archive}

if [[ ! -f "$VAULT_DIR/core-memory.md" ]]; then
  cat > "$VAULT_DIR/core-memory.md" << 'EOF'
# Core Memory & Intent

## Intent Anchor
(Define the current main objective)

## Rules & Constraints
- (Constraint 1)

## World State
(Quick summary of the project context)
EOF
fi

# --- Maps of Content ---

for type in notes ideas journals bugs decisions features learnings snippets episodics schemas; do
  if [[ ! -f "$VAULT_DIR/maps/$type.md" ]]; then
    title="$(echo "$type" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')"
    cat > "$VAULT_DIR/maps/$type.md" << EOF
# $title

## Recent

## By Project
EOF
  fi
done

# --- Index (dashboard) ---

if [[ ! -f "$VAULT_DIR/index.md" ]]; then
  cat > "$VAULT_DIR/index.md" << 'EOF'
# Mentat Vault

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
EOF
fi

# --- Obsidian configuration ---

if [[ ! -d "$VAULT_DIR/.obsidian" ]]; then
  mkdir -p "$VAULT_DIR/.obsidian"
  cat > "$VAULT_DIR/.obsidian/app.json" << 'EOF'
{
  "useMarkdownLinks": false,
  "newLinkFormat": "shortest",
  "showUnsupportedLinks": true,
  "strictLineBreaks": false,
  "readableLineLength": true
}
EOF
  cat > "$VAULT_DIR/.obsidian/graph.json" << 'EOF'
{
  "collapse-filter": false,
  "search": "",
  "showTags": true,
  "showAttachments": false,
  "hideUnresolved": false,
  "showOrphans": true,
  "collapse-color-groups": false,
  "colorGroups": [
    {"query": "tag:#type/bug", "color": {"a": 1, "rgb": 16711680}},
    {"query": "tag:#type/schema", "color": {"a": 1, "rgb": 65535}},
    {"query": "tag:#type/decision", "color": {"a": 1, "rgb": 16776960}}
  ],
  "collapse-display": false,
  "showArrow": true,
  "textFadeMultiplier": 0,
  "nodeSizeMultiplier": 1,
  "lineSizeMultiplier": 1
}
EOF
fi

echo "✓ Vault initialized at $VAULT_DIR"
echo ""
echo "To use in Obsidian:"
echo "  1. Open Obsidian"
echo "  2. File → Open vault"
echo "  3. Select folder: $VAULT_DIR"
