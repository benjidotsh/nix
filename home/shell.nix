{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      # Node Version Manager
      export NVM_DIR="$HOME/.nvm"
      [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
      [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
    '';
    profileExtra = ''
      eval "$(brew shellenv)"
    '';
  };

  home.shellAliases = {
  };
}
