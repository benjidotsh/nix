{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      export PATH="$PATH:$HOME/go/bin"

      # Node Version Manager
      export NVM_DIR="$HOME/.nvm"
      [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
      [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

      # zcli
      export AWS_CA_BUNDLE=/opt/homebrew/etc/ca-certificates/cert.pem;
      export NODE_EXTRA_CA_CERTS=/Users/bejanssens/.zcli/zscaler_root.pem;
    '';
    profileExtra = ''
      eval "$(brew shellenv)"
    '';
  };

  home.shellAliases = {
  };
}
