#!/usr/bin/env bash

set -e

# =====================================================
# Story Generator CLI
# Usage:
#   ./generate-story.sh "Story Title Here"
# =====================================================

if [ -z "$1" ]; then
  echo "Usage: ./generate-story.sh \"Story Title\""
  exit 1
fi

TITLE="$1"

# Slugify title for folder name
SLUG=$(echo "$TITLE" | \
  tr '[:upper:]' '[:lower:]' | \
  tr -cd 'a-z0-9 -' | \
  tr ' ' '-' | \
  sed 's/--*/-/g')

STORY_ID="ST-$(date +%Y%m%d)-$(date +%H%M%S)"

BASE_DIR="stories/drafts/$SLUG"

echo "========================================"
echo " Generating Story"
echo " Title: $TITLE"
echo " ID: $STORY_ID"
echo " Path: $BASE_DIR"
echo "========================================"

mkdir -p "$BASE_DIR"
mkdir -p "$BASE_DIR/images"

# -------------------------------
# story.md (master file)
# -------------------------------
cat <<EOF > "$BASE_DIR/story.md"
---
story_id: $STORY_ID
title: "$TITLE"
status: Draft

category:
  - Underdog Wins

emotional_hooks:
  - Recognition
  - Emotional Justice

created: $(date +%Y-%m-%d)
last_updated: $(date +%Y-%m-%d)

word_count_target: 15000
---

# Story Summary

TBD

# Chapter Status

- Chapter 1: Not Started
- Chapter 2: Not Started
- Chapter 3: Not Started
- Chapter 4: Not Started
- Chapter 5: Not Started
- Chapter 6: Not Started
- Chapter 7: Not Started
- Chapter 8: Not Started

# Notes

Add continuity notes here.
EOF

# -------------------------------
# outline.md
# -------------------------------
cat <<EOF > "$BASE_DIR/outline.md"
# Outline - $TITLE

## Act 1
- Setup protagonist
- Introduce conflict

## Act 2
- Escalation
- Emotional tension

## Act 3
- Major turning point
- Confrontation

## Act 4
- Resolution
- Emotional payoff
EOF

# -------------------------------
# characters.md
# -------------------------------
cat <<EOF > "$BASE_DIR/characters.md"
# Characters - $TITLE

## Protagonist
Name: TBD
Role: Underdog

## Antagonist
Name: TBD
Role: Opposition force

## Supporting Characters
- TBD
EOF

# -------------------------------
# prompts.md (AI helper file)
# -------------------------------
cat <<EOF > "$BASE_DIR/prompts.md"
# AI Prompts - $TITLE

## Story Expansion Prompt
Write the next chapter of this story in emotional justice style with strong cliffhangers.

## Character Consistency Prompt
Maintain established personalities and emotional arcs.

## Tone Prompt
Authoritative storytelling with emotional depth and realism.
EOF

# -------------------------------
# chapters placeholders
# -------------------------------
for i in {1..8}
do
cat <<EOF > "$BASE_DIR/chapter-$i.md"
# Chapter $i - $TITLE

TBD
EOF
done

echo "========================================"
echo " Story Generated Successfully"
echo "========================================"
echo "Location: $BASE_DIR"
echo "Next step: open story.md and start building"
echo "========================================"
