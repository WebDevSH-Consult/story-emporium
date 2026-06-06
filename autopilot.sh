#!/usr/bin/env bash
set -e

# =====================================================
# STORY EMPIRE AUTOPILOT
# Runs full story generation loop automatically
# =====================================================

LOG="autopilot.log"

echo "====================================" | tee -a $LOG
echo " AUTOPILOT STARTED: $(date)" | tee -a $LOG
echo "====================================" | tee -a $LOG

while true
do
  echo "" | tee -a $LOG
  echo "[$(date)] Generating new story..." | tee -a $LOG

  # 1. Generate story idea
  OUTPUT=$(./story-assembler.sh)

  echo "Story idea generated: $OUTPUT" | tee -a $LOG

  # 2. Run full factory pipeline
  ./story-factory.sh "$OUTPUT"

  echo "Story completed: $OUTPUT" | tee -a $LOG

  # 3. Wait before next story (control rate)
  echo "Sleeping..." | tee -a $LOG
  sleep 3600   # 1 story per hour (adjust as needed)

done