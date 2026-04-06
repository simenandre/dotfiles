{ ... }:

{
  home.file.".claude/CLAUDE.md".text = ''
    # Code Style

    - ONLY use comments to explain weird code or non-obvious behaviour, never to explain simple code.

    # Git & PRs

    - ALWAYS write short and concise git commit messages and pull request messages.
    - NEVER include a Co-Authored-By: line in commits.
    - NEVER include "Generated with [Claude Code]" in PRs.

    # Docker & Runtimes

    - ALWAYS use the latest LTS version for base Docker images, Node.js engine requirements and similar.
    - ALWAYS strive to use base Docker images with common ancestors in multi-stage builds: a stage based on `debian:trixie-slim` strongly suggests using `node:24-trixie-slim`.

    # Nix

    - If a command is not available and there is a `flake.nix` in the project, use `nix develop` or `nix run` to run commands from the flake's dev shell instead of installing tools manually.

    # Loggie

    - If the Loggie MCP server is available, use the `/session` skill to annotate what you are working on at the start of a session and when the task changes.
    - When ending a conversation or the user says goodbye, use `/session end` to clean up.
  '';

  home.file.".claude/skills/session/SKILL.md".text = ''
    ---
    name: session
    description: Start or end a work session — annotates via Loggie and sets the tmux window title.
    allowed-tools: mcp__loggie__annotate, Bash(tmux rename-window *)
    ---

    # /session — Work Session Management

    You are executing the /session skill. This skill manages Loggie annotations and tmux window titles.

    ## Arguments

    - `/session <description>` — Start or update the current session with a description of what you're working on.
    - `/session end` — End the current session.

    ## Starting / Updating a Session

    1. Use the Loggie `annotate` MCP tool with the provided description. Keep it short and descriptive (e.g. "Fixing auth bug in login flow", "Adding CSV export endpoint").
    2. Set the tmux window title using `tmux rename-window "<title>"`. The title should be very short and recognizable — it does not need to match the annotation exactly.

    ## Ending a Session

    1. Call the Loggie `annotate` MCP tool with an empty string to stop the current annotation.
    2. Reset the tmux window title using `tmux rename-window "zsh"`.
  '';

  home.file.".claude/skills/push/SKILL.md".text = ''
    ---
    name: push
    description: Create a commit and push changes. Optionally creates a branch and opens a PR with an intelligently chosen reviewer.
    disable-model-invocation: true
    ---

    # /push — Commit & Push Workflow

    You are executing the /push skill. Follow these steps precisely.

    ## Step 1: Analyze Changes

    Run `git status` and `git diff` (staged + unstaged) to understand all current changes.
    If there are no changes to commit, inform the user and stop.

    ## Step 2: Stage Files

    Stage the relevant files. Prefer `git add <specific files>` over `git add -A`.
    Never stage files that look like secrets (.env, credentials, tokens).

    ## Step 3: Ask — Branch or Main?

    Use the **AskUserQuestion** tool to ask the user how to push. Example:

    - question: "How should this be pushed?"
    - header: "Push target"
    - options:
      - label: "Current branch", description: "Push directly to the current branch"
      - label: "New branch + PR", description: "Create a new branch and open a pull request"

    ### If "Current branch":

    - Run `git push` (with `-u` if needed).
    - Done.

    ### If "New branch + PR":

    1. Create a descriptive branch name based on the changes (e.g., `feat/add-logging`, `fix/null-check-user`).
    2. Check out the new branch and push with `-u`.
    3. **Choose a reviewer:**
       - Run `git log --format='%an' -50 | sort | uniq -c | sort -rn | head -10` to find active contributors.
       - Cross-reference with files changed: run `git log --format='%an' -- <changed-files> | sort | uniq -c | sort -rn | head -5` to find who has context on the modified code.
       - Pick the most relevant reviewer (not the current user — check with `git config user.name`).
       - Build a list of up to 4 candidate reviewers and use **AskUserQuestion** to let the user pick. Example:
         - question: "Who should review this PR?"
         - header: "Reviewer"
         - options: one per candidate, with description showing their commit count / relevance to changed files.
    4. Create the PR using `gh pr create`:
       - Short title (under 70 chars).
       - Body with a `## Summary` section (2-3 bullet points) and a `## Test plan` section.
       - Add the confirmed reviewer with `--reviewer`.
    5. Return the PR URL to the user.
    
    ## Step 4: Create Commit

    - Analyze the staged diff.
    - Write a concise commit message using **conventional commit format** (e.g., `feat:`, `fix:`, `refactor:`, `chore:`, `docs:`, `test:`, `ci:`). Include a scope when it adds clarity (e.g., `feat(auth):`, `fix(api):`).
    - Output ONLY the raw commit message — no markdown, no code blocks, no backticks, no explanations.
    - **Do NOT add a Co-Authored-By line. Never include any co-author trailer.**
    - Create the commit using a HEREDOC for the message.
  '';
}
