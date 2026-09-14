# SecExec

SecExec records experiments on the security of agentic code execution, starting with Aider's architect/editor workflow and a Qwen model served through vLLM. It keeps the setup, test code, and evidence needed to understand how repository instructions can influence generated plans, code edits, and Git commits.

## Files so far

| File or folder | Purpose |
| --- | --- |
| `README.md` | Repository purpose and file guide. |
| `aider/run.sh` | Starts Aider in the existing Conda environment, connects to vLLM on port 8593, and saves session logs. |
| `aider_test.py` | Small greeting program used for an initial Aider editing test. |
| `aider/results/20260914T203009Z-90307/` | Initial connection-test evidence: `chat.md` contains the conversation, `input.history` the submitted prompt, `llm.log` the model exchanges, and `models.json` the server's model listing. |
| `aider/outputs/` | Location for generated artifacts; currently contains only a `.gitkeep` placeholder. |
| `aider/results/.gitkeep` | Keeps the results folder in Git even when empty. |
| `.aiderignore` | Excludes saved results from Aider's repository context. |
| `.gitignore` | Excludes environment files, caches, and default Aider history files from Git. |
