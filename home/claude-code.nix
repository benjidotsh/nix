{...}: {
  programs.claude-code = {
    enable = true;

    mcpServers = {
      context7 = {
        command = "npx";
        args = ["-y" "@upstash/context7-mcp"];
      };

      github = {
        type = "http";
        url = "https://api.githubcopilot.com/mcp";
        headers = {
          Authorization = "Bearer \${GITHUB_PAT}";
        };
      };
    };

    memory.text = ''
      # Memory

      ## DON'T talk too much

      In all interactions and commit messages, be extremely concise and sacrifice grammar for the sake of concision.

      ## DON'T make assumptions

      At the end of each plan, give me a list of unresolved questions to answer, if any. Make the questions extremely concise. Sacrifice grammar for the sake of concision.

      ## DO use Context7

      Always use context7 when I need code generation, setup or configuration steps, or library/API documentation. This means you should automatically use the Context7 MCP tools to resolve library id and get library docs without me having to explicitly ask.
    '';
  };
}
