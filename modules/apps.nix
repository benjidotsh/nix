{
  config,
  lib,
  profile,
  nix-vscode-extensions,
  ...
}: {
  environment.variables.EDITOR = "code --wait";

  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps =
      {
        "The Unarchiver" = 425424353;
        "Boop" = 1518425043;
        "Spark Classic" = 1176895641;
        "Messenger" = 1480068668;
        "WhatsApp Messenger" = 310633997;
        "1Password for Safari" = 1569813296;
        "TestFlight" = 899247664;
      }
      // (lib.optionalAttrs (profile == "work") {
        "Slack" = 803453959;
      });

    # `brew install`
    brews =
      [
        "just"
        "folderify"
        "volta"
        "opencode"
      ]
      ++ (lib.optionals (profile == "personal") [
        "bun"
      ])
      ++ (lib.optionals (profile == "work") [
        "awscli"
        "sops"
        "aws-sam-cli"
        "valkey"
      ]);

    # `brew install --cask`
    casks =
      [
        "discord"
        "spotify"
        "1password"
        "monitorcontrol"
      ]
      ++ (lib.optionals (profile == "personal") [
        "steam"
        "bambu-studio"
        "autodesk-fusion"
        "openscad@snapshot"
        "adobe-acrobat-reader"
        "beid-token"
        "orbstack"
      ])
      ++ (lib.optionals (profile == "work") [
        "postgres-unofficial"
        "httpie-desktop"
        "leapp"
        "dbeaver-community"
        "session-manager-plugin"
        "nosql-workbench"
        "docker-desktop"
      ]);

    # https://github.com/zhaofengli/nix-homebrew/issues/5#issuecomment-1878798641
    taps = builtins.attrNames config.nix-homebrew.taps;
  };

  nixpkgs = {
    # Allow unfree packages
    config.allowUnfree = true;

    overlays = [
      nix-vscode-extensions.overlays.default
    ];
  };
}
