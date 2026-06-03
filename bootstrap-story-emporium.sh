#!/usr/bin/env bash

set -e

echo "========================================"
echo " Story Emporium Bootstrap"
echo "========================================"

ROOT="story-empire"

echo "Creating root directory..."
mkdir -p "$ROOT"

cd "$ROOT"

echo "Creating folder structure..."

mkdir -p story-bible
mkdir -p story-bible/categories
mkdir -p story-bible/characters
mkdir -p story-bible/prompts
mkdir -p story-bible/title-templates

mkdir -p stories/drafts
mkdir -p stories/editing
mkdir -p stories/published
mkdir -p stories/archived

mkdir -p website/assets
mkdir -p website/images
mkdir -p website/seo

mkdir -p prompts

echo "Creating starter files..."

cat <<'EOF' > README.md
# Story Empire

AI-powered storytelling system for scalable short fiction production.

## Structure

- story-bible: system rules
- stories: all story content
- website: publishing layer
- prompts: AI generation tools
EOF

cat <<'EOF' > story-bible/story-categories.md
# Story Categories

This file will contain 50 emotional story categories.
EOF

cat <<'EOF' > story-bible/title-generators.md
# Title Generator System

Template-based title creation for scalable story production.
EOF

echo "========================================"
echo " Bootstrap complete"
echo "========================================"