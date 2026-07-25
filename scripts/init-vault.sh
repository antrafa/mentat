#!/usr/bin/env bash
# Initializes the Memory Vault directory structure at ~/.memory_vault
# Safe to run multiple times — skips if vault already exists.
set -euo pipefail

VAULT_DIR="${HOME}/.memory_vault"

if [[ -d "$VAULT_DIR/entries" ]]; then
  echo "✓ Vault already exists at $VAULT_DIR"
  exit 0
fi

echo "Creating Memory Vault at $VAULT_DIR..."

mkdir -p "$VAULT_DIR"/{entries,maps,daily}

# --- Maps of Content ---

for type in bugs decisions features learnings snippets; do
  title="$(echo "$type" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')"
  cat > "$VAULT_DIR/maps/$type.md" << EOF
# $title

## Recent

## Por projeto
EOF
done

# --- Index (dashboard) ---

cat > "$VAULT_DIR/index.md" << 'EOF'
# Memory Vault

## Maps of Content

- [[bugs]] — Bugs corrigidos e sessões de debug
- [[decisions]] — Decisões de arquitetura e design
- [[features]] — Features construídas
- [[learnings]] — Coisas aprendidas
- [[snippets]] — Padrões de código e receitas

## Entradas recentes
EOF

echo "✓ Vault initialized at $VAULT_DIR"
echo ""
echo "Para usar no Obsidian:"
echo "  1. Abra o Obsidian"
echo "  2. File → Open vault"
echo "  3. Selecione a pasta: $VAULT_DIR"
