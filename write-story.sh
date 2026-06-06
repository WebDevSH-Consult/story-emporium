#!/usr/bin/env bash
set -e

DIR="$1"

if [ -z "$OPENAI_API_KEY" ]; then
  echo "Missing OPENAI_API_KEY"
  exit 1
fi

SYSTEM="You are a bestselling short story writer. Maintain emotional justice style storytelling."

for i in {1..8}
do
  PROMPT=$(cat <<EOF
Write Chapter $i of a serialized emotional justice story based on existing outline and characters in $DIR.
Ensure continuity and end with a hook.
EOF
)

  RESPONSE=$(curl -s https://api.openai.com/v1/chat/completions \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{
      "model": "gpt-4o-mini",
      "messages": [
        {"role": "system", "content": "$SYSTEM"},
        {"role": "user", "content": "$PROMPT"}
      ]
    }")

  TEXT=$(echo "$RESPONSE" | python3 -c "import sys, json; print(json.load(sys.stdin)['choices'][0]['message']['content'])")

  echo "$TEXT" > "$DIR/chapter-$i.md"
done
