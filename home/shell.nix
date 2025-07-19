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
    sessionVariables = lib.optionalAttrs (profile == "work") {
      VOLTA_HOME = "$HOME/.volta";
      AWS_CA_BUNDLE = "/opt/homebrew/etc/ca-certificates/cert.pem";
      NODE_EXTRA_CA_CERTS = "$HOME/.zcli/zscaler_root.pem";
    };

    sessionPath = lib.optionals (profile == "work") [
      "$VOLTA_HOME/bin"
    ];
  };
}
