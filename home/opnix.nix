{config, ...}: {
  programs.onepassword-secrets = {
    enable = true;
    tokenFile = "${config.home.homeDirectory}/.config/opnix/token";

    secrets = {
      context7 = {
        reference = "op://Nix/Secrets/Context7";
        path = ".config/opnix/context7";
        mode = "0600";
      };

      github = {
        reference = "op://Nix/Secrets/GitHub";
        path = ".config/opnix/github";
        mode = "0600";
      };
    };
  };
}
