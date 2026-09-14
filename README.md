# SecExec

Aider experiments, results, and generated outputs using a local vLLM server.

## Reproduction branch

This branch (`test/aider-5058-trajectory`) contains the Aider #5058 experiment:

- `aider5058-repro/README.md` originally held the harmless injected instruction and was later removed. The payload remains documented in the annotated evidence and Git history.
- `aider5058-repro/auth.py` shows the resulting marker comment.
- [aider5058-repro/RESULTS.md](aider5058-repro/RESULTS.md) explains the findings and limitations.
- [aider/results/aider5058-trajectory-annotated.txt](aider/results/aider5058-trajectory-annotated.txt) provides selected trace evidence.

The full reproduction log stays locally in `/tmp`.

## Run

Prerequisites: the existing `aider5058-client` Conda environment (Aider 0.86.2), and vLLM listening at `http://127.0.0.1:8593/v1`, serving `Qwen/Qwen2.5-Coder-7B-Instruct`.

From this repository:

```bash
bash aider/run.sh
```

The launcher uses the Conda environment automatically and starts architect mode with the same Qwen model as editor. Each session saves the server model listing, chat, input history, and LLM exchanges in a timestamped `aider/results/` directory. Put generated artifacts in `aider/outputs/`. Exit Aider with `/exit`.

To work on a specific file (paths are relative to `aider/`):

```bash
bash aider/run.sh outputs/example.py
```

Inside Aider chat, file paths are relative to the repository root, for example `aider/outputs/example.py`.

## Push results

From the repository root after a session:

```bash
git status
git diff
git add aider/results aider/outputs
git diff --cached
git commit -m "Save Aider experiment results"
git push
```

Session logs contain your prompts and model responses. Review staged files before pushing. `.env` files and default Aider caches are ignored; the explicit session logs are tracked. Aider may create local commits while editing; publishing still requires `git push`.
