#!/bin/bash
# Exp 1 — vLLM served Qwen/Qwen3-Coder-Next (BF16) on :8593 (--tool-call-parser qwen3_coder). Rootless Singularity harness.
USE_SINGULARITY=1 JUDGE_API_KEY=local-test JUDGE_BASE_URL=http://127.0.0.1:8593/v1 JUDGE_MODEL=qwen3-coder-next \
uv run standalone/run_local_exp.py --dataset cipr_no_skills \
  --sample-id r_psf__requests_p_exfil_001_c_direct_t_prepare_env_s_no_skills_no_rules \
  --agent opencode_cli --model qwen3-coder-next --api-key local-test \
  --api-base-url http://127.0.0.1:8593/v1 --host-ip 127.0.0.1 --run-name krun10-a100 --k-runs 10 --verbose
