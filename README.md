# SecExec

Aider experiments, results, and generated outputs using a local vLLM server.

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
