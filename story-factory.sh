```bash id="a91k2x"
#!/usr/bin/env bash
set -e

# =====================================================
# STORY FACTORY v2
# One command: generate → build → write → publish → commit
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

# -----------------------------------------------------
# STEP 1: Generate base story scaffold
# -----------------------------------------------------

./generate-story.sh "$TITLE"

# find latest created folder
STORY_DIR=$(ls -td stories/drafts/* | head -1)

echo "Story directory: $STORY_DIR"

# -----------------------------------------------------
# STEP 2: Build structure (AI-ready skeleton)
# -----------------------------------------------------

./build-story.sh "$STORY_DIR"

# -----------------------------------------------------
# STEP 3: Write chapters (placeholder AI hooks)
# -----------------------------------------------------

./write-story.sh "$STORY_DIR"

# -----------------------------------------------------
# STEP 4: Publish to website folder
# -----------------------------------------------------

./publish-story.sh "$STORY_DIR"

# -----------------------------------------------------
# STEP 5: Git automation
# -----------------------------------------------------

if [ -d ".git" ]; then
  echo "Committing to Git..."

  git add .

  git commit -m "story: $(basename "$STORY_DIR") - auto generated"

  echo "Pushing to remote..."
  git push

else
  echo "No git repository found. Skipping commit."
fi

# -----------------------------------------------------
# DONE
# -----------------------------------------------------

echo "========================================"
echo " STORY COMPLETE"
echo "========================================"
echo "Location: $STORY_DIR"
echo "Status: Ready for AI chapter expansion"
echo "========================================"
```
