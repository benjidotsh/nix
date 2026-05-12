{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;

    settings = {
      theme = "Catppuccin Macchiato";
    };
  };
}
