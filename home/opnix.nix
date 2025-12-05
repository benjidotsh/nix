{config, ...}: {
  programs.onepassword-secrets = {
    enable = true;
    tokenFile = "${config.home.homeDirectory}/.config/opnix/token";

    secrets = {
      context7 = {
        reference = "op://Nix/Context7/referentie";
        path = ".config/opnix/context7";
        mode = "0600";
      };
    };
  };
}
