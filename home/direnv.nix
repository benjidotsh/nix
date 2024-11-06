{...}: {
  programs.direnv = {
    enable = true;
    config = {
      "load_dotenv" = true;
    };
  };
}
