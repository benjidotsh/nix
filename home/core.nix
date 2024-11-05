{pkgs, ...}: {
  home.packages = with pkgs; [
    # Nix
    alejandra
    nixd
  ];
}
