{
  pkgs,
  lib,
  profile,
  ...
}: {
  programs.vscode = {
    enable = true;

    package = pkgs.antigravity;

    profiles.default = {
      extensions = with pkgs.vscode-marketplace;
      with pkgs.vscode-marketplace-release;
        [
          esbenp.prettier-vscode
          dbaeumer.vscode-eslint
          eamodio.gitlens
          jnoortheen.nix-ide
          jlcodes.antigravity-cockpit

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
          # Antigravity
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
