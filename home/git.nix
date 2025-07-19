{
  lib,
  userfullname,
  useremail,
  signingKey,
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

    userName = userfullname;
    userEmail = useremail;

    includes = lib.optionals (profile == "work") [
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

      gpg = {
        format = "ssh";
        ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
    };

    signing = {
      key = signingKey;
      signByDefault = true;
    };

    aliases = {
      amend = "commit --amend";
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
