{...}: {
  programs.mcp = {
    enable = true;

    servers = {
      context7 = {
        command = "npx";
        args = ["-y" "@upstash/context7-mcp" "--api-key" "{env:CONTEXT7_API_KEY}"];
      };

      github = {
        url = "https://api.githubcopilot.com/mcp";
        headers = {
          Authorization = "Bearer {env:GITHUB_PAT}";
        };
      };
    };
  };
}
