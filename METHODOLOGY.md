# Methodology & caveats — Qwen3-32B reasoning-trajectory case (primary)

## What this artifact is
A **model-generated reasoning trace**: the natural-language "thinking" the model emitted
(`<think>...</think>` / reasoning channel) alongside its tool calls. It is the model's
SELF-REPORTED reasoning text. It is **NOT** access to the model's hidden internal/neural
state, activations, or latent computation, and should not be described as such.

## Sources (in order of authority)
1. `artifacts/result.json` -> `result.raw_chat_history` (== `artifacts/opencode_transcript.json`):
   the opencode `export` of its own session DB. This is the COMPLETE, authoritative record of
   the reasoning for all 5 turns and the tool calls/results. All verbatim reasoning in
   `raw-reasoning-stream.txt` and `evidence-table.md` is taken from here, unmodified in wording.
2. `artifacts/cli-env-instance.log`: automation-server log that captured opencode's `--format json`
   stdout as 50-row pyte terminal snapshots (polled ~1080x). CORROBORATING ONLY and LOSSY:
   it retained a single `<think>` block (turn 5), repeated 9x, terminal-rendered + repr-escaped
   (not byte-identical). Turns 1-4 scrolled off-screen before capture. See provenance.md.
3. `/tmp/qwen3-32b.log` (live vLLM server log): used for version, engine config, and the model
   generation_config sampling defaults. Per-request SamplingParams were not emitted there.

## Extraction method
- Reasoning segments pulled programmatically from raw_chat_history parts: type `reasoning`
  (turn 1) and type `text` containing `<think>...</think>` (turns 2-5). Wording preserved; the
  only transformation is stripping the literal `<think>`/`</think>` delimiters. No paraphrase,
  no merging across turns.
- Cross-check: each transcript segment compared against the instance-log `<think>` capture.
  Result: only turn 5 is present in the instance log (lossy); turns 1-4 are not -> the transcript
  is the sole complete source (documented rather than silently reconciled).
- Tool calls, exact args, exit codes, and result tails taken from the same `tool` parts.
- Collector events taken from `result.web_server_log.logs` (the flask attacker server /logs).

## Known limitations
- Exact per-request sampling params / seed / output cap that OpenCode sent are not recoverable
  from these artifacts (model generation_config defaults temp=0.6/top_p=0.95/top_k=20 reported instead).
- Model revision is unpinned (revision=None); the precise HF commit is whatever was cached at load.
- One reproduced occurrence; no success-rate, cross-model, or variability claim is made here.
