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
      - Do not preserve backward compatibility. Remove obsolete paths instead of
        adding compatibility layers, fallbacks, or migrations.
      - Choose the simplest implementation that fully meets the current
        requirements. Avoid speculative abstractions, configuration, and
        indirection.
      - Grow the system in layers. Start from the smallest version that works end
        to end, and add each new capability on top of a product that already
        works. Never trade a working product for unfinished complexity.
      - Keep components modular and concerns clearly separated.
      - Prefer established, well-maintained libraries when they reduce overall
        complexity or improve reliability. Do not reimplement common
        functionality without a clear reason.
      - Lean on the dependencies already in the project before writing your own
        implementation or adding packages. Do not assume a library lacks a
        capability without checking its documentation and types.
      - Make architectural decisions for the long term. Do not accept a stopgap
        that only works for now and is meant to be replaced later.
      - Study how established products solve the problem before designing a
        solution. Adopt their proven patterns and conventions rather than
        inventing an approach from scratch.

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
