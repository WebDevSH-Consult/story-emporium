#!/usr/bin/env bash
set -e

# Generates 5 stories then commits and pushes once.
# Designed for automated/CI use — no interactive input required.
# Requires: OPENAI_API_KEY env var

STORIES_TO_GENERATE=${1:-5}

if [ -z "$OPENAI_API_KEY" ]; then
  echo "ERROR: OPENAI_API_KEY is not set"
  exit 1
fi

LOG="weekly-run.log"
GENERATED_TITLES=()

echo "========================================" | tee -a "$LOG"
echo " WEEKLY RUN STARTED: $(date)" | tee -a "$LOG"
echo " Generating $STORIES_TO_GENERATE stories" | tee -a "$LOG"
echo "========================================" | tee -a "$LOG"

for i in $(seq 1 "$STORIES_TO_GENERATE"); do
  TITLE=$(./story-assembler.sh)
  echo "" | tee -a "$LOG"
  echo "[$i/$STORIES_TO_GENERATE] Title: $TITLE" | tee -a "$LOG"

  ./generate-story.sh "$TITLE"

  STORY_DIR=$(ls -td stories/drafts/* | head -1)
  echo "  Directory: $STORY_DIR" | tee -a "$LOG"

  ./build-story.sh "$STORY_DIR"
  ./write-story.sh "$STORY_DIR"
  ./publish-story.sh "$STORY_DIR"

  GENERATED_TITLES+=("$TITLE")
  echo "  Done." | tee -a "$LOG"
done

echo "" | tee -a "$LOG"
echo "========================================" | tee -a "$LOG"
echo " All stories complete. Committing..." | tee -a "$LOG"
echo "========================================" | tee -a "$LOG"

git add stories/

COMMIT_MSG="auto: weekly batch $(date +%Y-%m-%d)"$'\n'$'\n'
for TITLE in "${GENERATED_TITLES[@]}"; do
  COMMIT_MSG+="- $TITLE"$'\n'
done

git commit -m "$COMMIT_MSG"
git push

echo "Done. $(date)" | tee -a "$LOG"
