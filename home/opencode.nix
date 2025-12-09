{...}: {
  programs.opencode = {
    enable = true;

    settings = {
      mcp = {
        context7 = {
          type = "local";
          command = ["npx" "-y" "@upstash/context7-mcp" "--api-key" "{env:CONTEXT7_API_KEY}"];
          enabled = true;
        };

        github = {
          type = "remote";
          url = "https://api.githubcopilot.com/mcp";
          headers = {
            Authorization = "Bearer {env:GITHUB_PAT}";
          };
          enabled = true;
        };

        shadcn = {
          type = "local";
          args = ["npx" "shadcn@latest" "mcp"];
          enabled = true;
        };
      };
    };

    rules = ''
      # Custom instructions

      ## DON'T talk too much

      In all interactions and commit messages, be extremely concise and sacrifice grammar for the sake of concision.

      ## DON'T make assumptions

      At the end of each plan, give me a list of unresolved questions to answer, if any. Make the questions extremely concise. Sacrifice grammar for the sake of concision.

      ## DO use Context7

      Always use context7 when I need code generation, setup or configuration steps, or library/API documentation. This means you should automatically use the Context7 MCP tools to resolve library id and get library docs without me having to explicitly ask.
    '';
  };
}
