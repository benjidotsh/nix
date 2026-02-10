{...}: {
  programs.go = {
    enable = true;
    env = {
      GONOSUMDB = "persgroep.cloud/*";
    };
  };
}
