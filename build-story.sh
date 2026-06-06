#!/usr/bin/env bash
set -e

DIR="$1"

cat <<EOF >> "$DIR/story.md"

# AI STRUCTURE
- Structure created
EOF

cat <<EOF > "$DIR/outline.md"
Act 1 setup
Act 2 conflict
Act 3 escalation
Act 4 resolution
EOF

cat <<EOF > "$DIR/characters.md"
Hero: TBD
Antagonist: TBD
Love interest: TBD
EOF
