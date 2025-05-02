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
      {
        path = "/Applications/NoSQL Workbench.app";
        icon = ./nosql_workbench.icns;
      }
      {
        path = "/Users/${username}/DPG";
        icon = ./dpg_media.icns;
      }
    ];
  };
}
