{
  username,
  userfullname,
  hostname,
  ...
}:
#############################################################
#
#  Host & Users configuration
#
#############################################################
{
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    home = "/Users/${username}";
    description = userfullname;
  };
  system.primaryUser = username;

  nix.settings.trusted-users = [username];
}
