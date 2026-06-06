#!/usr/bin/env bash
set -e

echo "Starting daily story generation..."

./story-assembler.sh
./story-factory.sh "$(cat story-bible/memory/last-generated-story.json | jq -r .title)"

git add .
git commit -m "auto-story $(date)"
git push

echo "Done."