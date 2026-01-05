{...}: {
  programs.zed-editor = {
    enable = true;

    extensions = [
      "catppuccin"
      "catppuccin-icons"
      "just"
      "nix"
    ];

    userSettings = {
      icon_theme = {
        mode = "system";
        light = "Catppuccin Latte";
        dark = "Catppuccin Macchiato";
      };
      theme = {
        mode = "system";
        light = "Catppuccin Latte";
        dark = "Catppuccin Macchiato";
      };
      terminal = {
        font_family = "MesloLGS Nerd Font";
      };
    };

    mutableUserSettings = false;
  };
}
