{username, ...}: {
  environment.customIcons = {
    enable = true;
    icons = [
      {
        path = "/Applications/Spotify.app";
        icon = ./spotify.icns;
      }
      {
        path = "/Users/${username}/Applications/Stardew Valley.app";
        icon = ./stardew_valley.icns;
      }
      {
        path = "/Applications/Steam.app";
        icon = ./steam.icns;
      }
    ];
  };
}
