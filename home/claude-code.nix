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
          Authorization = "Bearer \${GITHUB_PAT}";
        };
      };
    };

    memory.text = ''
      - Be extremely concise. Sacrifice grammar for the sake of concision.
      - Prefer minimal, happy-path solutions. Do NOT over-engineer (e.g., dedup pools, helper exports, service-layer abstractions) unless explicitly requested.
      - Prefer libraries over custom code when a well-known library covers the use case.
    '';
  };
}
