# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Zynkr Writing Agent is a modular, multi-stage article writing pipeline built entirely on Claude Code skills and agents. It orchestrates 7 specialized agents that guide an article from initial idea through publication-ready copy with CTAs. All agent prompts are written in Traditional Chinese (zh-TW); the orchestrator responds in whatever language the user writes in.

## Architecture

```
Entry: /write-article skill → SKILL.md orchestrator
  ↓ detects user's current stage from input
  ↓ routes via Task tool to one of 7 agents:

Stage 0: socratic-ideation-partner  — Socratic dialogue for vague ideas
Stage 1: article-style-selector     — Picks from 9 structure templates
Stage 2: article-drafter            — Writes ~400 words/section per turn
Stage 3: article-editor             — Editorial review + forbidden-word check
Stage 3.5: reader-perspective       — 100-point scoring (optional)
Stage 4: article-title-suggester    — 10 SEO-optimized title candidates
Stage 5: cta-writer                 — 3 CTA options from 6 predefined types
```

**Key design rules:**
- Agents are stateless and independent — each receives full context from the previous stage
- The orchestrator never auto-chains stages; it always asks the user before advancing
- Entry point detection uses a decision tree (no content → Stage 0, topic + thoughts → Stage 1, confirmed outline → Stage 2, completed draft → Stage 3+)

## Key File Locations

| What | Path |
|------|------|
| Orchestrator | `.claude/skills/write-article/SKILL.md` |
| Agent definitions | `.claude/agents/*.md` (7 files) |
| Guide/reference docs | `[A-G1]*.md` at repo root (12 files, ~47 KB) |
| Eval outputs | `write-article-workspace/eval-{0,1,2}/` |

Guide files are numbered reference material that map to stages:
- `[A]` → Stage 0, `[B]/[B1]` → Stage 1, `[C]/[C1]` → Stage 2
- `[D]/[D1]` → Stage 3, `[E]` → Stage 3.5, `[F]/[F1]` → Stage 4, `[G]/[G1]` → Stage 5

## Running

```bash
claude    # then invoke /write-article
```

Or with a topic: `/write-article 我想寫一篇關於AI工具的文章`

Individual agents can also be triggered directly by providing appropriate content (e.g., pasting a draft auto-routes to the editor agent).

## Evaluation

Evals live in `write-article-workspace/` (gitignored). Each eval folder contains:
- `eval_metadata.json` — input/output config
- `grading.json` — assertions and pass/fail breakdown
- `outputs/transcript.md` — execution log

Run evals via the skill-creator plugin's `prepare_eval.py` script (see `.claude/settings.local.json` for the allowed command).

## Conventions

- Agent files use YAML frontmatter (`name`, `description`, `model`) followed by a Markdown system prompt
- All agents default to `model: sonnet`
- CTA links and SEO keyword lists are hardcoded in the agent prompts and guide files — update them there directly when they change
