{
  lib,
  userfullname,
  useremail,
  profile,
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

    settings = {
      user = {
        name = userfullname;
        email = useremail;
      };

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;

      gpg = {
        format = "ssh";
        ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };

      alias = {
        amend = "commit --amend";
      };
    };

    includes = lib.optionals (profile == "work") [
      {
        # use a different config for work
        path = "~/DPG/.ssh/.gitconfig";
        condition = "gitdir:~/DPG/";
      }
    ];

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSK4eeyfGaWuK2Arns3PyagHUh9IyyYC/L4ZqC9K085";
      signByDefault = true;
    };
  };

  home.file = lib.optionalAttrs (profile == "work") {
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
