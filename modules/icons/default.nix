{
  username,
  lib,
  profile,
  ...
}: {
  environment.customIcons = {
    enable = true;
    icons =
      (lib.optionals (profile == "personal") [
        {
          path = "/Applications/Steam.app";
          icon = ./steam.icns;
        }
        {
          path = "/Users/${username}/Applications/Stardew Valley.app";
          icon = ./stardew_valley.icns;
        }
      ])
      ++ (lib.optionals (profile == "work") [
        {
          path = "/Users/${username}/DPG";
          icon = ./dpg_media.icns;
        }
        {
          path = "/Applications/NoSQL Workbench.app";
          icon = ./nosql_workbench.icns;
        }
      ]);
  };
}
