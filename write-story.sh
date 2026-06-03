```bash id="v9k3bb"
#!/usr/bin/env bash
set -e

STORY_DIR="$1"

if [ -z "$STORY_DIR" ]; then
  echo "Usage: ./write-story.sh stories/drafts/your-story"
  exit 1
fi

echo "Writing chapters..."

for i in {1..8}
do
cat <<EOF > "$STORY_DIR/chapter-$i.md"
# Chapter $i

[AI GENERATED CONTENT PLACEHOLDER]

Prompt:
Write Chapter $i of this story using emotional justice storytelling.
Maintain continuity.
End with a hook for next chapter.
EOF
done

echo "Chapters created."
```
