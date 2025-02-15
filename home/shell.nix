{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    initExtra = ''
      # Node Version Manager
      [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
      [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
    '';

    profileExtra = ''
      eval "$(brew shellenv)"
    '';

    sessionVariables = {
      PATH = "$PATH:$HOME/go/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools";
      NVM_DIR = "$HOME/.nvm";
      AWS_CA_BUNDLE = "/opt/homebrew/etc/ca-certificates/cert.pem";
      NODE_EXTRA_CA_CERTS = "$HOME/.zcli/zscaler_root.pem";
      JAVA_HOME = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home";
      ANDROID_HOME = "$HOME/Library/Android/sdk";
    };
  };
}
