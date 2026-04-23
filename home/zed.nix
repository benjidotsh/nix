{...}: {
  programs.zed-editor = {
    enable = true;

    extensions = ["catppuccin" "catppuccin-icons"];

    userSettings = {
      agent_servers = {
        claude-acp = {
          type = "registry";
        };
      };

      icon_theme = {
        mode = "dark";
        light = "Zed (Default)";
        dark = "Catppuccin Macchiato";
      };

      session = {
        trust_all_worktrees = true;
      };

      ui_font_size = 16;

      buffer_font_size = 15;

      theme = {
        mode = "dark";
        light = "One Light";
        dark = "Catppuccin Macchiato";
      };
    };

    mutableUserSettings = false;
  };
}
