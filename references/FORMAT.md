# Entry Format Reference

This file contains templates and conventions for every vault artifact. The agent loads this when writing entries.

## Frontmatter

Every entry starts with YAML frontmatter:

```yaml
---
type: note | idea | journal | bug | decision | feature | learning | snippet | episodic | schema
date: YYYY-MM-DD
tags: [tag1, tag2]
project: project-name
salience: 100
usage_count: 0
status: open | resolved | superseded
related: ["[[entry-slug]]"]
---
```

## Core Memory

O arquivo `~/.mentat/core-memory.md` é a âncora de contexto do agente, lido apenas sob demanda.

```markdown
# Core Memory & Intent

## Objetivo Atual (Intent Anchor)
{O grande objetivo ou missão em andamento}

## Regras e Restrições
- {restrição 1}
- {restrição 2}

## Estado do Mundo
{resumo rápido do contexto geral atual, max 500 palavras}
```

## Entry Templates

> **ATENÇÃO:** O Mentat prefere **Atomic Bullets**. Não escreva parágrafos longos. Destile a informação em tópicos diretos, concisos e acionáveis.

### Episodic

```markdown
---
type: episodic
date: {date}
tags: [{tags}]
project: {project}
salience: 100
usage_count: 0
status: resolved
related: []
---

# {title}

## Evento

- **Quando:** {YYYY-MM-DD HH:MM}
- **Quem:** {Claude / Codex / Usuário}
- **Ação:** {O que foi feito de forma atômica}

## Resultado
{Impacto da ação}
```

### Schema

```markdown
---
type: schema
date: {date}
tags: [{tags}]
project: {project}
salience: 200
usage_count: 0
status: open
related: ["[[entry-1]]", "[[entry-2]]"]
---

# {title}

## Padrão Abstrato
{A regra geral ou padrão derivado das várias entries relacionadas}

## Aplicação
{Como aplicar esse padrão no futuro}
```

### Note

```markdown
---
type: note
date: {date}
tags: [{tags}]
project: {project}
status: open
related: []
---

# {title}

## Tópicos Principais

{resumo dos tópicos da nota}

## Detalhes

{corpo da nota}
```

### Idea

```markdown
---
type: idea
date: {date}
tags: [{tags}]
project: {project}
status: open
related: []
---

# {title}

## O que é

{descrição rápida da ideia}

## Por que importa

{qual o valor ou problema que resolve}

## Próximos passos

{o que precisa acontecer para virar realidade}
```

### Journal

```markdown
---
type: journal
date: {date}
tags: [{tags}]
project: {project}
status: open
related: []
---

# {title}

## Reflexão do Dia

{o que aconteceu, pensamentos, estado mental}

## Pontos Positivos

- {coisa 1}

## Desafios

- {desafio 1}
```

### Bug

```markdown
---
type: bug
date: {date}
tags: [{tags}]
project: {project}
status: resolved
related: []
---

# {title}

## Sintomas

{o que foi observado — erro, comportamento inesperado}

## Causa raiz

{por que aconteceu}

## Correção

{o que foi alterado para corrigir}

## Arquivos alterados

- `path/to/file.ext`

## Lições

{o que observar da próxima vez}
```

### Decision

```markdown
---
type: decision
date: {date}
tags: [{tags}]
project: {project}
status: open
related: []
---

# {title}

## Contexto

{situação que exigiu a decisão}

## Opções consideradas

1. **{opção A}** — {prós e contras}
2. **{opção B}** — {prós e contras}

## Decisão

{qual opção foi escolhida}

## Justificativa

{por que esta opção, não as outras}

## Consequências

{o que muda a partir dessa decisão — tradeoffs aceitos}
```

### Feature

```markdown
---
type: feature
date: {date}
tags: [{tags}]
project: {project}
status: resolved
related: []
---

# {title}

## O que foi construído

{descrição do que a feature faz}

## Abordagem

{como foi implementado — arquitetura, padrões usados}

## Arquivos-chave

- `path/to/file.ext` — {papel do arquivo}

## Pontos de atenção

{edge cases, limitações conhecidas, débito técnico}
```

### Learning

```markdown
---
type: learning
date: {date}
tags: [{tags}]
project: {project}
status: open
related: []
---

# {title}

## Insight

{o que foi aprendido — a lição central em 1-2 frases}

## Contexto

{como/onde esse conhecimento surgiu}

## Detalhes

{explicação mais profunda, exemplos, referências}

## Aplicação

{quando e como usar esse conhecimento no futuro}
```

### Snippet

```markdown
---
type: snippet
date: {date}
tags: [{tags}]
project: {project}
status: open
related: []
---

# {title}

## Quando usar

{situação em que esse padrão se aplica}

## Código

\```{language}
{código}
\```

## Notas

{variações, cuidados, alternativas}
```

## Map of Content (MOC)

Cada tipo tem um MOC em `~/.mentat/maps/{type}s.md`:

```markdown
# {Type}s

## Recent

- [[YYYY-MM-DD-slug]] — resumo em uma linha

## Por projeto

### [[project-name]]

- [[YYYY-MM-DD-slug]] — resumo em uma linha
```

Ao adicionar uma entrada, insira na seção `## Recent` no topo. Quando um projeto acumular 5+ entradas na seção Recent, mova-as para uma subseção `### [[project-name]]` sob `## Por projeto`.

## Daily Note

Notas diárias vivem em `~/.mentat/daily/YYYY-MM-DD.md`:

```markdown
# {YYYY-MM-DD}

## Entradas

- [[YYYY-MM-DD-slug]] — resumo ({type})
```

## Index

O arquivo `~/.mentat/index.md` é o dashboard do vault:

```markdown
# Memory Vault

## Maps of Content

- [[bugs]] — Bugs corrigidos e sessões de debug
- [[decisions]] — Decisões de arquitetura e design
- [[features]] — Features construídas
- [[learnings]] — Coisas aprendidas
- [[snippets]] — Padrões de código e receitas

## Entradas recentes

(últimas 10 entradas linkadas aqui)
```

## Convenções de nomenclatura

| Elemento | Formato | Exemplo |
|----------|---------|---------|
| Arquivo de entrada | `YYYY-MM-DD-slug.md` | `2024-03-15-fix-auth-token-refresh.md` |
| Slug | kebab-case, max 6 palavras | `fix-auth-token-refresh` |
| Wiki-link | `[[kebab-case]]` | `[[react]]`, `[[retry-with-backoff]]` |
| Tag | `#categoria/subcategoria` | `#lang/typescript`, `#infra/docker` |

## Tags recomendadas

Categorias de tag para manter consistência:

- `#lang/` — linguagens (`#lang/typescript`, `#lang/python`)
- `#framework/` — frameworks (`#framework/nextjs`, `#framework/fastapi`)
- `#infra/` — infraestrutura (`#infra/docker`, `#infra/aws`)
- `#pattern/` — padrões (`#pattern/retry`, `#pattern/circuit-breaker`)
- `#domain/` — domínio de negócio (`#domain/auth`, `#domain/payments`)
- `#tool/` — ferramentas (`#tool/git`, `#tool/obsidian`)
