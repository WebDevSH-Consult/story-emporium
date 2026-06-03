```bash id="m2p9cc"
#!/usr/bin/env bash
set -e

STORY_DIR="$1"

if [ -z "$STORY_DIR" ]; then
  echo "Usage: ./publish-story.sh stories/drafts/your-story"
  exit 1
fi

TITLE=$(grep "title:" "$STORY_DIR/story.md" | cut -d '"' -f2)

SLUG=$(basename "$STORY_DIR")

PUBLISH_DIR="stories/published/$SLUG"

echo "Publishing story..."

mkdir -p "$PUBLISH_DIR"

cp -r "$STORY_DIR"/* "$PUBLISH_DIR"

cat <<EOF > "$PUBLISH_DIR/index.md"
# $TITLE

This story is part of Story Emporium.

Read full chapters below:
EOF

echo "Published to $PUBLISH_DIR"
```
