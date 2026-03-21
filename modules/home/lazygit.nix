{ ... }:

{
  home.file.".config/lazygit/config.yml".text = ''
    git:
      pagers:
        - colorArg: always
          pager: delta --dark --paging=never
    customCommands:
      - key: "C"
        context: "files"
        description: "Generate commit message with Claude Code"
        command: >
          git diff --staged | $HOME/.local/bin/claude -p 'Generate a concise git commit message for these staged changes.
            Output ONLY the raw commit message with no markdown, no code blocks, no backticks, no explanations.
            Use conventional commit format.' --model haiku --output-format text > /tmp/commit_msg &&
            GIT_EDITOR=nvim git commit -e -F /tmp/commit_msg
        output: terminal
  '';
}
