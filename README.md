# Zynkr Writing Agent

A modular article writing pipeline built on [Claude Code](https://claude.ai/claude-code), designed for Zynkr's content team. Seven specialized agents handle each stage of the writing process — from ideation to CTA — orchestrated by a single `/write-article` command.

## Pipeline Overview

```
 Ideation → Structure → Drafting → Editing → Titles → CTA
   (0)        (1)        (2)        (3)       (4)     (5)
```

| Stage | Agent | What It Does |
|-------|-------|--------------|
| 0 | `socratic-ideation-partner` | Guides vague ideas into a refined premise through Socratic dialogue |
| 1 | `article-style-selector` | Recommends article structures (9 templates) and maps section key points |
| 2 | `article-drafter` | Writes the draft section-by-section (~1000–1200 words) following a style guide |
| 3 | `article-editor` | Reviews against editorial rules, checks forbidden words, removes AI-sounding language |
| 3.5 | `reader-perspective` | (Optional) Scores the article on a 100-point rubric with critical analysis |
| 4 | `article-title-suggester` | Generates 10 SEO-optimized title suggestions |
| 5 | `cta-writer` | Produces 3 CTA options matched to the article's goal |

## Quick Start

### Prerequisites

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed and authenticated

### Usage

Open the project directory in Claude Code:

```bash
cd "Writing agent"
claude
```

Then invoke the orchestrator:

```
/write-article
```

The orchestrator detects what you already have and starts from the appropriate stage. You can also pass a topic directly:

```
/write-article 我想寫一篇關於AI工具的文章
```

### Using Individual Agents

Each agent can also be invoked independently via the Task tool. For example, if you only need editing:

```
Help me edit this article: [paste your draft]
```

Claude will automatically route to the `article-editor` agent.

## Project Structure

```
.claude/
├── agents/
│   ├── socratic-ideation-partner.md   # Stage 0 — Ideation
│   ├── article-style-selector.md      # Stage 1 — Structure
│   ├── article-drafter.md             # Stage 2 — Drafting
│   ├── article-editor.md              # Stage 3 — Editing
│   ├── reader-perspective.md          # Stage 3.5 — Review (optional)
│   ├── article-title-suggester.md     # Stage 4 — SEO Titles
│   └── cta-writer.md                  # Stage 5 — CTA
└── skills/
    └── write-article/
        └── SKILL.md                   # Pipeline orchestrator
```

## Language

The agents and style guides are written in Traditional Chinese (zh-TW), reflecting Zynkr's target audience. The orchestrator responds in whichever language the user writes in.

## License

Private project — all rights reserved.
