{...}: {
  programs.firefox = {
    enable = true;

    profiles.default = {
      bookmarks = {
        force = true;
        settings = [
          {
            toolbar = true;
            bookmarks = [
              {
                name = "Directory";
                bookmarks = [
                  {
                    name = "Bookmark 1";
                    url = "https://www.google.com";
                  }
                ];
              }
              {
                name = "Bookmark 2";
                url = "https://wiki.nixos.org/";
              }
            ];
          }
        ];
      };
    };
  };
}
