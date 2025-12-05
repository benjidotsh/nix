{
  pkgs,
  lib,
  profile,
  ...
}: {
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-marketplace;
      with pkgs.vscode-marketplace-release;
        [
          esbenp.prettier-vscode
          dbaeumer.vscode-eslint
          eamodio.gitlens
          jnoortheen.nix-ide
          anthropic.claude-code

          # Catppuccin
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons

          # GitHub Copilot
          github.copilot
          github.copilot-chat
        ]
        ++ (lib.optionals (profile == "personal") [
          bradlc.vscode-tailwindcss
          platformio.platformio-ide
          prisma.prisma
          antyos.openscad
        ]);
      userSettings =
        {
          # Visual Studio Code
          "workbench.startupEditor" = "none";
          "security.workspace.trust.enabled" = false;
          "editor.fontFamily" = "MesloLGS Nerd Font, Menlo, Monaco, 'Courier New', monospace";
          "editor.tabSize" = 2;
          "editor.fontLigatures" = true;

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
          };

          # GitHub Copilot
          "github.copilot.enable" = {
            "*" = true;
            "plaintext" = false;
            "markdown" = true;
            "scminput" = false;
          };
          "github.copilot.nextEditSuggestions.enabled" = true;
          "chat.tools.autoApprove" = true;
          "chat.agent.maxRequests" = 100;

          # JavaScript/TypeScript
          "typescript.preferences.importModuleSpecifier" = "non-relative";
          "javascript.preferences.importModuleSpecifier" = "non-relative";
        }
        // (lib.optionalAttrs (profile == "personal") {
          # Prisma
          "[prisma]" = {
            "editor.defaultFormatter" = "prisma.prisma";
          };
        });
    };

    mutableExtensionsDir = true;
  };
}
