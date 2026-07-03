{...}: {
  programs.claude-code = {
    enable = true;
    enableMcpIntegration = true;

    mcpServers = {
      context7 = {
        command = "npx";
        args = ["-y" "@upstash/context7-mcp" "--api-key" "\${CONTEXT7_API_KEY}"];
      };

      github = {
        type = "http";
        url = "https://api.githubcopilot.com/mcp";
        headers = {
          Authorization = "Bearer \${GH_TOKEN}";
        };
      };
    };

    context = ''
      ## General

      - Be extremely concise. Sacrifice grammar for the sake of concision.
      - Prefer minimal, happy-path solutions. Do NOT over-engineer (e.g., dedup pools, helper exports, service-layer abstractions) unless explicitly requested.
      - Prefer libraries over custom code when a well-known library covers the use case.

      ## Superpowers workflow overrides

      (These outrank skill defaults.)

      - Specs → `.superpowers/specs/`, plans → `.superpowers/plans/` (repo root).
        Never commit them; a single `.gitignore` containing `*` in `.superpowers/`
        keeps it all untracked.
      - No spec-review step: summarize the spec inline, flag assumptions/open
        questions, wait for my reply before writing-plans.
      - Worktrees: always create one before changing code, no consent prompt (unless
        already isolated); use `.worktrees/<branch>`. Skip the check-ignore gate and
        never touch repo `.gitignore`s — after creating the worktree, drop a
        `.gitignore` containing `*` in `.worktrees/` instead.
      - Finishing a branch: skip the menu, always "keep as-is"; report branch +
        worktree path.
    '';
  };
}
