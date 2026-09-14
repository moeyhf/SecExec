#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
export OPENAI_API_BASE="${OPENAI_API_BASE:-http://127.0.0.1:8593/v1}"
export OPENAI_API_KEY="${OPENAI_API_KEY:-dummy}"
run_dir="results/$(date -u +%Y%m%dT%H%M%SZ)-$$"
mkdir -p "$run_dir" outputs
curl --fail --silent --show-error --max-time 10 "$OPENAI_API_BASE/models" > "$run_dir/models.json"
printf 'Session logs: %s/%s\n' "$PWD" "$run_dir"
exec conda run --no-capture-output -n aider5058-client aider \
  --architect \
  --no-show-model-warnings \
  --model openai/Qwen/Qwen2.5-Coder-7B-Instruct \
  --editor-model openai/Qwen/Qwen2.5-Coder-7B-Instruct \
  --openai-api-base "$OPENAI_API_BASE" \
  --openai-api-key "$OPENAI_API_KEY" \
  --no-analytics --no-check-update --no-show-release-notes \
  --chat-history-file "$run_dir/chat.md" \
  --input-history-file "$run_dir/input.history" \
  --llm-history-file "$run_dir/llm.log" \
  "$@"
