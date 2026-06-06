#!/usr/bin/env bash
set -e

# =====================================================
# STORY FACTORY v2 (CLEAN BASH VERSION)
# =====================================================

if [ -z "$1" ]; then
  echo "Usage: ./story-factory.sh \"Story Title\""
  exit 1
fi

TITLE="$1"

echo "========================================"
echo " STORY FACTORY INITIATED"
echo "========================================"
echo "Title: $TITLE"

# STEP 1 - Generate base story
./generate-story.sh "$TITLE"

# Get latest story folder
STORY_DIR=$(ls -td stories/drafts/* | head -1)

echo "Story directory: $STORY_DIR"

# STEP 2 - Build structure
./build-story.sh "$STORY_DIR"

# STEP 3 - Create chapters
./write-story.sh "$STORY_DIR"

# STEP 4 - Publish
./publish-story.sh "$STORY_DIR"

# STEP 5 - Git commit
if [ -d ".git" ]; then
  echo "Committing to Git..."

  git add .

  git commit -m "story: $TITLE"

  git push
else
  echo "No git repo found - skipping commit"
fi

echo "========================================"
echo " STORY COMPLETE"
echo "========================================"
echo "Location: $STORY_DIR"