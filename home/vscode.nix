{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = [
      pkgs.vscode-extensions.esbenp.prettier-vscode
      pkgs.vscode-extensions.dbaeumer.vscode-eslint
      pkgs.vscode-extensions.eamodio.gitlens
      pkgs.vscode-extensions.jnoortheen.nix-ide

      # Catppuccin
      pkgs.vscode-extensions.catppuccin.catppuccin-vsc
      pkgs.vscode-extensions.catppuccin.catppuccin-vsc-icons
    ];
    userSettings = {
      # Visual Studio Code
      "workbench.startupEditor" = "none";
      "security.workspace.trust.enabled" = false;

      # Prettier
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.formatOnSave" = true;
      "prettier.requireConfig" = true;

      # ESLint
      "editor.codeActionsOnSave" = {
        "source.fixAll" = "explicit";
      };

      # GitLens
      "gitlens.codeLens.enabled" = false;

      # Catppuccin
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.iconTheme" = "catppuccin-macchiato";

      # Nix
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = ["alejandra"];
          };
        };
      };
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
        "editor.formatOnSave" = true;
      };
    };
    mutableExtensionsDir = false;
  };
}
