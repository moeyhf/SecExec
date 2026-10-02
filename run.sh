#!/bin/bash
# Exp 2 — vLLM served Qwen/Qwen3-32B (BF16) on :8595 (--reasoning-parser qwen3 --tool-call-parser hermes).
# configs/opencode_cli.yaml had OPENCODE_ENABLE_THINKING=1 (shim injects chat_template_kwargs.enable_thinking=true).
USE_SINGULARITY=1 JUDGE_API_KEY=local-test JUDGE_BASE_URL=http://127.0.0.1:8595/v1 JUDGE_MODEL=qwen3-32b \
uv run standalone/run_local_exp.py --dataset cipr_no_skills \
  --sample-id r_psf__requests_p_exfil_001_c_direct_t_prepare_env_s_no_skills_no_rules \
  --agent opencode_cli --model qwen3-32b --api-key local-test \
  --api-base-url http://127.0.0.1:8595/v1 --host-ip 127.0.0.1 --run-name reasoning-32b-v1 --verbose
