{ ... }:

{
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

    ## Step 3: Create Commit

    - Analyze the staged diff and recent `git log --oneline -10` to match the repo's commit style.
    - Write a concise, meaningful commit message (1-2 sentences) focusing on the "why".
    - **Do NOT add a Co-Authored-By line. Never include any co-author trailer.**
    - Create the commit using a HEREDOC for the message.

    ## Step 4: Ask — Branch or Main?

    Ask the user:

    > Push directly to the current branch, or create a new branch and open a PR?

    Present the two options clearly and wait for a response.

    ### Option A: Push to current branch

    - Run `git push` (with `-u` if needed).
    - Done.

    ### Option B: New branch + PR

    1. Create a descriptive branch name based on the changes (e.g., `feat/add-logging`, `fix/null-check-user`).
    2. Check out the new branch and push with `-u`.
    3. **Choose a reviewer:**
       - Run `git log --format='%an' -50 | sort | uniq -c | sort -rn | head -10` to find active contributors.
       - Cross-reference with files changed: run `git log --format='%an' -- <changed-files> | sort | uniq -c | sort -rn | head -5` to find who has context on the modified code.
       - Pick the most relevant reviewer (not the current user — check with `git config user.name`).
       - Present your choice to the user and ask for confirmation before proceeding.
    4. Create the PR using `gh pr create`:
       - Short title (under 70 chars).
       - Body with a `## Summary` section (2-3 bullet points) and a `## Test plan` section.
       - Add the confirmed reviewer with `--reviewer`.
    5. Return the PR URL to the user.
  '';
}
