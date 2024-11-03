{pkgs, ...}: {
  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    vscode
    git
    just # use Justfile to simplify nix-darwin's commands
  ];
  environment.variables.EDITOR = "code --wait";

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      # cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      "Xcode" = 497799835;
      "Spark Classic" = 1176895641;
      "Slack" = 803453959;
      "Messenger" = 1480068668;
      "WhatsApp Messenger" = 310633997;
      "The Unarchiver" = 425424353;
      "Wipr" = 1320666476;
    };

    # `brew install`
    brews = [
      "nvm"
    ];

    # `brew install --cask`
    casks = [
      "google-chrome"
      "discord"
      "spotify"
      "orbstack"
      "postgres-unofficial"
      "httpie"
      "1password"
    ];
  };
}
