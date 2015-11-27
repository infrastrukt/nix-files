{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    weechat
    mutt
  ];

  systemd.services.ircSession = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "forking";
      User = "irc";
      ExecStart = ''${pkgs.tmux}/bin/tmux new-session -s irc ${pkgs.weechat}/bin/weechat'';
      ExecStop = ''${pkgs.tmux}/bin/tmux kill-session -t irc'';
    };
  };

  users.extraUsers.irc = {
    isNormalUser = true;
    home = "/home/irc";
  };
}
