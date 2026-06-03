```bash id="x7k2aa"
#!/usr/bin/env bash
set -e

STORY_DIR="$1"

if [ -z "$STORY_DIR" ]; then
  echo "Usage: ./build-story.sh stories/drafts/your-story"
  exit 1
fi

echo "Building story structure..."

TITLE=$(grep "title:" "$STORY_DIR/story.md" | cut -d '"' -f2)

cat <<EOF >> "$STORY_DIR/story.md"

# AI GENERATED STRUCTURE

## Status
Structure Created

EOF

cat <<EOF > "$STORY_DIR/characters.md"
# Characters - $TITLE

## Protagonist
Name: Jake Carter
Archetype: Underdog Builder
Flaw: Self-doubt

## Antagonist
Name: Rival Family Member
Archetype: Status-driven elite
Flaw: Arrogance

## Love Interest
Name: Emma-style character
Archetype: High-status professional
Flaw: Emotional fatigue
EOF

cat <<EOF > "$STORY_DIR/outline.md"
# Outline - $TITLE

## Act 1: Setup
Protagonist is undervalued

## Act 2: Disruption
Unexpected encounter changes trajectory

## Act 3: Escalation
Conflict between worlds emerges

## Act 4: Payoff
Emotional justice delivered

## Act 5: Resolution
New identity established
EOF

echo "Build complete."
```
