{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        identityAgent = "'~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock'";
      };
    };
  };

  # disable the "Last login" message
  home.file.".hushlogin".text = "";
}
