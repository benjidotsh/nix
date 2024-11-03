{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = [
      pkgs.vscode-extensions.esbenp.prettier-vscode
      pkgs.vscode-extensions.dbaeumer.vscode-eslint
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
    };
    mutableExtensionsDir = false;
  };
}
