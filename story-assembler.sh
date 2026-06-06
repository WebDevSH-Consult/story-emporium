#!/usr/bin/env bash
set -e

NAMES=("Jake" "Emma" "Noah" "Olivia" "Mia" "Ethan")
PLOTS=("underdog wins" "family betrayal" "hidden success" "second chance romance")
TWISTS=("secret ownership reveal" "unexpected inheritance" "public reversal")

TITLE="The ${NAMES[$RANDOM % 6]} Effect"

echo "$TITLE"
