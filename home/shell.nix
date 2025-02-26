{...}: {
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
    sessionVariables = {
      VOLTA_HOME = "$HOME/.volta";
      AWS_CA_BUNDLE = "/opt/homebrew/etc/ca-certificates/cert.pem";
      NODE_EXTRA_CA_CERTS = "$HOME/.zcli/zscaler_root.pem";
      JAVA_HOME = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home";
      ANDROID_HOME = "$HOME/Library/Android/sdk";
    };

    sessionPath = [
      "$HOME/go/bin"
      "$ANDROID_HOME/emulator"
      "$ANDROID_HOME/platform-tools"
      "$VOLTA_HOME/bin"
    ];
  };
}
