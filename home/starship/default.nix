{lib, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings =
      lib.recursiveUpdate
      (builtins.fromTOML (builtins.readFile ./presets/nerd-font-symbols.toml))
      {
        docker_context = {
          disabled = true;
        };

        git_status = {
          disabled = true;
        };

        aws = {
          format = "on [$symbol$region]($style) ";
        };
      };
  };
}
