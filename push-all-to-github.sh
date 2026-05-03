#!/bin/bash

# Push all 50 projects to GitHub
# This script runs /project-push-to-github for each project sequentially

echo "🚀 Starting push of all 50 projects to GitHub..."
echo ""

# Loop through projects 001-050
for i in $(seq -f "%03g" 1 50); do
  echo "📦 Pushing project $i to GitHub..."
  # Note: This requires running within Claude Code CLI
  # You'll need to execute this interactively or modify to use claude CLI directly
  echo "/project-push-to-github $i"
done

echo ""
echo "✓ All projects queued for GitHub push"
echo ""
echo "To execute this script:"
echo "1. In Claude Code CLI, run each command shown above sequentially"
echo "2. Or use: for i in {001..050}; do /project-push-to-github \$i; done"
