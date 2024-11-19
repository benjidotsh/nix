{
  lib,
  userfullname,
  useremail,
  ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = userfullname;
    userEmail = useremail;

    includes = [
      {
        # use a different config for work
        path = "~/DPG/.ssh/.gitconfig";
        condition = "gitdir:~/DPG/";
      }
    ];

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      gpg.format = "ssh";
      gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSK4eeyfGaWuK2Arns3PyagHUh9IyyYC/L4ZqC9K085";
      signByDefault = true;
    };

    delta = {
      enable = true;
      options = {
        features = "side-by-side";
      };
    };

    aliases = {
      # common aliases
      br = "branch";
      co = "checkout";
      st = "status";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      cm = "commit -m";
      ca = "commit -am";
      dc = "diff --cached";
      amend = "commit --amend -m";

      # aliases for submodule
      update = "submodule update --init --recursive";
      foreach = "submodule foreach";
    };
  };

  home.file = {
    "DPG/.ssh/.gitconfig" = {
      text = ''
        [core]
          sshCommand = ssh -i ~/DPG/.ssh/id_ed25519

        [user]
          email = benjamin.janssens@persgroep.net
          signingkey = ~/DPG/.ssh/id_ed25519.pub
      '';
    };
  };
}
