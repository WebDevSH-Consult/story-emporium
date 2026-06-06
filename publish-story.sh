#!/usr/bin/env bash
set -e

DIR="$1"
NAME=$(basename "$DIR")

mkdir -p stories/published/$NAME
cp -r "$DIR"/* stories/published/$NAME/
