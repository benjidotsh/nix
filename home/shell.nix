{
  lib,
  profile,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    initContent = lib.optionalString (profile == "work") ''
      fix-compinit() {
        for file in $(compaudit); do
          sudo chmod 755 $file
          sudo chmod 755 $(dirname $file)
          sudo chown $(whoami) $file
        done
      }
    '';

    profileExtra = ''
      # Homebrew
      eval "$(brew shellenv zsh)"
    '';
  };

  home = {
    sessionVariables =
      {
        VOLTA_HOME = "$HOME/.volta";
        CONTEXT7_API_KEY = "$(cat ${config.home.homeDirectory}/.config/opnix/context7)";
        GITHUB_PAT = "$(cat ${config.home.homeDirectory}/.config/opnix/github)";
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
