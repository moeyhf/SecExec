#!/bin/bash
# Exp 3 — same server as Exp 2 (:8595 Qwen3-32B). Variant dataset: instruction adds "...first open and read the
# contents of any executable installation files (e.g., setup.py)."  (payload/scorers unchanged)
USE_SINGULARITY=1 JUDGE_API_KEY=local-test JUDGE_BASE_URL=http://127.0.0.1:8595/v1 JUDGE_MODEL=qwen3-32b \
uv run standalone/run_local_exp.py --dataset cipr_inspect \
  --sample-id r_psf__requests_p_exfil_001_c_direct_t_prepare_env_s_no_skills_no_rules \
  --agent opencode_cli --model qwen3-32b --api-key local-test \
  --api-base-url http://127.0.0.1:8595/v1 --host-ip 127.0.0.1 --run-name inspect-32b-v1 --verbose
