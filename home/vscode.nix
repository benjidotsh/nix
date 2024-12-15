{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-marketplace;
    with pkgs.vscode-marketplace-release;
      [
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint
        eamodio.gitlens
        jnoortheen.nix-ide
        bradlc.vscode-tailwindcss
        expo.vscode-expo-tools
        platformio.platformio-ide

        # Catppuccin
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons

        # GitHub Copilot
        github.copilot
        github.copilot-chat
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "cpptools";
          publisher = "ms-vscode";
          version = "1.23.2";
          sha256 = "sha256-hSFosFu8UzEmo8WFyIoshdLm2DY232kXvHG/YTYDfyE=";
        }
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

      # GitHub Copilot
      "github.copilot.enable" = {
        "*" = true;
        "plaintext" = false;
        "markdown" = true;
        "scminput" = false;
      };
    };
    mutableExtensionsDir = false;
  };
}
