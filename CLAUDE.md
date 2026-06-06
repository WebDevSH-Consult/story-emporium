# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Project Is

Story Emporium is an AI-powered short fiction production pipeline. It uses shell scripts to scaffold story files, call the OpenAI API to write chapter content, and publish stories to a structured folder layout. The target output is 8-chapter serialized stories (~15,000 words each) in an "emotional justice" style (underdog wins, public reversal, secret success).

## Pipeline Overview

The full pipeline runs in sequence:

1. **`generate-story.sh "Title"`** — creates the draft folder under `stories/drafts/<slug>/` with scaffolded `story.md`, `outline.md`, `characters.md`, `prompts.md`, and 8 empty chapter files.
2. **`build-story.sh <story-dir>`** — appends a structure block to `story.md` and overwrites `outline.md` and `characters.md` with placeholder content.
3. **`write-story.sh <story-dir>`** — calls OpenAI (`gpt-4o-mini`) to generate each of the 8 chapters. Requires `OPENAI_API_KEY` env var.
4. **`publish-story.sh <story-dir>`** — copies the completed draft to `stories/published/<slug>/`.

**`story-factory.sh "Title"`** chains all four steps, then auto-commits and pushes to git.

**`autopilot.sh`** runs story-factory in an infinite loop (1 story/hour), using `story-assembler.sh` to generate random titles.

**`daily-run.sh`** is a one-shot variant that reads a title from `story-bible/memory/last-generated-story.json` (requires `jq`).

## Running a Story

```bash
# Single story end-to-end
export OPENAI_API_KEY=sk-...
./story-factory.sh "The Title Goes Here"

# Just scaffold files (no API call)
./generate-story.sh "My Story Title"

# Write chapters only (story must already be scaffolded)
./write-story.sh stories/drafts/<slug>

# Continuous autopilot
./autopilot.sh   # logs to autopilot.log
```

## Story Bible

- `story-bible/memory/names.md` — character name pool used by `story-assembler.sh`
- `story-bible/memory/story-plots.md` — plot archetypes (underdog wins, family betrayal, etc.)
- `story-bible/memory/emotional-hooks.md` — emotional hooks to layer in (recognition, public reversal, etc.)
- `story-bible/memory/twists.md` — twist options (secret ownership reveal, unexpected inheritance, etc.)
- `story-bible/story-categories.md` and `title-generators.md` — stubs awaiting expansion

## Story File Format

Every story lives under `stories/drafts/<slug>/` with this layout:

```
story.md          # YAML frontmatter (story_id, title, status, category, emotional_hooks) + chapter status tracker
outline.md        # 4-act structure
characters.md     # Protagonist / antagonist / supporting cast
prompts.md        # AI prompt templates for expansion and consistency
chapter-1.md      # through chapter-8.md
images/           # (empty, reserved for cover art)
```

`story_id` format: `ST-YYYYMMDD-HHMMSS`

## Story Lifecycle

```
stories/drafts/     → in-progress
stories/editing/    → manual review (not yet wired into scripts)
stories/published/  → after publish-story.sh
stories/archived/   → retired stories
```

## Key Constraints

- `write-story.sh` uses `python3` to parse the OpenAI JSON response — Python 3 must be on PATH.
- `daily-run.sh` requires `jq` to parse `story-bible/memory/last-generated-story.json`; that file is not auto-created by any current script.
- `story-assembler.sh` currently only generates `"The <Name> Effect"` titles — the plots/twists arrays are defined inline but not yet used in title construction.
- `generate-story.sh` is wrapped in backtick fences in the file on disk, making it non-executable as written — the actual runnable copy used by `story-factory.sh` should not have those fences.
