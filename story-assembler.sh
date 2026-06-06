#!/usr/bin/env bash
set -e

NAMES=("Jake" "Emma" "Noah" "Olivia" "Mia" "Ethan" "Ryan" "Sophia" "Marcus" "Diane" "Leo" "Priya")

TEMPLATES=(
  "The {NAME} Effect"
  "What {NAME} Knew"
  "The Last Bet {NAME} Made"
  "Everything {NAME} Built"
  "The Day {NAME} Stopped Pretending"
  "How {NAME} Won"
  "The Mistake That Made {NAME}"
  "Why They Underestimated {NAME}"
  "The Year {NAME} Came Back"
  "What They Took from {NAME}"
  "The Secret {NAME} Kept"
  "The Letter {NAME} Never Sent"
)

NAME=${NAMES[$RANDOM % ${#NAMES[@]}]}
TEMPLATE=${TEMPLATES[$RANDOM % ${#TEMPLATES[@]}]}

TITLE="${TEMPLATE/\{NAME\}/$NAME}"

echo "$TITLE"
