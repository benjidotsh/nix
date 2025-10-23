{
  lib,
  profile,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    profileExtra = ''
      # Homebrew
      eval "$(brew shellenv)"
    '';
  };

  home = {
    sessionVariables =
      {
        VOLTA_HOME = "$HOME/.volta";
      }
      // (lib.optionalAttrs (profile == "work") {
        AWS_CA_BUNDLE = "/opt/homebrew/etc/ca-certificates/cert.pem";
        NODE_EXTRA_CA_CERTS = "$HOME/.zcli/zscaler_root.pem";
      });

    sessionPath = ["$VOLTA_HOME/bin"];

    shellAliases = {
      update = "(cd ~/nix; git pull; just deploy)";
    };
  };
}
