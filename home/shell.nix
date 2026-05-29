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
        GH_TOKEN = "$(cat ${config.home.homeDirectory}/.config/opnix/github)";
      }
      // (lib.optionalAttrs (profile == "personal") {
        JAVA_HOME = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home";
        ANDROID_HOME = "$HOME/Library/Android/sdk";
      })
      // (lib.optionalAttrs (profile == "work") {
        AWS_CA_BUNDLE = "/opt/homebrew/etc/ca-certificates/cert.pem";
        NODE_EXTRA_CA_CERTS = "$HOME/.zcli/zscaler_root.pem";
        ARTIFACTORY_API_KEY = "$(cat ${config.home.homeDirectory}/.config/opnix/artifactory)";
        GOPROXY = "https://bejanssens:$ARTIFACTORY_API_KEY@artifactory.persgroep.cloud/artifactory/api/go/go,https://proxy.golang.org,direct";
      });

    sessionPath =
      [
        "$VOLTA_HOME/bin"
      ]
      ++ (lib.optionals (profile == "personal") [
        "$ANDROID_HOME/emulator"
        "$ANDROID_HOME/platform-tools"
      ])
      ++ (lib.optionals (profile == "work") [
        "$HOME/go/bin"
      ]);

    shellAliases = {
      nix-sync = "(cd ~/nix; git pull; just deploy)";
      nix-update = "(cd ~/nix; just up; git add flake.lock; git commit -m 'Update flake.lock'; git push; just deploy)";
    };
  };
}
