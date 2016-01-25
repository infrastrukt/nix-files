{ config, pkgs, ... }:

{
  environment.systemPackages = let pkgsUnstable = import
  (
    fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz
  )
  { };
  in
  [
    tmux
    pkgsUnstable.weechat
    mutt
  ];

  users.users.irc =
  {
    isNormalUser = true;
    home = "/etc/user/irc";
    createHome = true;
    extraGroups = [ "git" ];
  };

  # TODO: Setup configs
  system.activationScripts =
  {
    usenet-home =
    {
      deps = [];
      text =
      ''
        ln -sf /etc/user/dotfiles/weechat /etc/user/irc/.weechat
      '';
    };
  };
}
