# SecExec

SecExec records experiments on the security of agentic code execution, starting with Aider's architect/editor workflow and a Qwen model served through vLLM. It keeps the setup, test code, and evidence needed to understand how repository instructions can influence generated plans, code edits, and Git commits.

## Plan-mediation experiment

This branch, `test/aider-5058-mediation`, contains an **indirect prompt-injection and plan-mediation experiment** in `aider5058-mediation/`.

- **Attack source:** a poisoned README contains an injected instruction.
- **Compromised planner:** the architect transfers the instruction into its plan.
- **Downstream executor:** the editor follows the transferred plan and modifies code, without directly receiving the poisoned README.
- **Control/ablation:** removing only the marker from the transferred plan prevented marker insertion in the control run.

In research terminology, the plan is the **mediating variable**, and insertion of `# AIDER_5058_MEDIATED_TRIGGER` is the **measured outcome**.

Paths below are relative to `aider5058-mediation/`, except the local `/tmp` logs.

| File | Purpose |
| --- | --- |
| [architect/README.md](aider5058-mediation/architect/README.md) | Contains the injected instruction. |
| [architect/auth.py](aider5058-mediation/architect/auth.py) | Clean code shown to the architect; the architect edit was rejected, leaving this file unchanged. |
| [treated-plan.txt](aider5058-mediation/treated-plan.txt) | Normalized transcription of the architect plan containing the marker. |
| [treated/auth.py](aider5058-mediation/treated/auth.py) | Treated editor output; the marker was inserted here. |
| [control-plan.txt](aider5058-mediation/control-plan.txt) | Same transferred plan with only the marker line removed. |
| [control/auth.py](aider5058-mediation/control/auth.py) | Control editor output; the marker is absent. |
| [RESULTS.md](aider5058-mediation/RESULTS.md) | Documents the experiment, results, conclusion, and limitations. |
| `/tmp/aider5058-*.log` | Local raw execution traces recording what each agent received and produced. The mediation traces are `aider5058-phase-a.log`, `aider5058-phase-b-treated.log`, and `aider5058-phase-c-control.log`; they are not included in this repository. |

This is a single-model, single-run experiment using a normalized plan transcription rather than a verbatim extraction. It concerns an observable planning artifact, not private chain-of-thought; repeated trials and verbatim plan transfer would strengthen the evidence.

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
