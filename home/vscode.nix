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
          github.copilot-chat
          anthropic.claude-code

          # Catppuccin
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
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
          "chat.agent.maxRequests" = 100;
          "chat.useAgentSkills" = true;

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

      userMcp = {
        servers = {
          "io.github.upstash/context7" = {
            type = "stdio";
            command = "npx";
            args = ["@upstash/context7-mcp@latest"];
          };

          "microsoft/playwright-mcp" = {
            type = "stdio";
            command = "npx";
            args = ["@playwright/mcp@latest"];
          };

          "io.github.github/github-mcp-server" = {
            type = "http";
            url = "https://api.githubcopilot.com/mcp";
            headers = {
              Authorization = "Bearer \${env:GITHUB_PAT}";
            };
          };
        };
      };
    };

    mutableExtensionsDir = profile == "personal";
  };
}
