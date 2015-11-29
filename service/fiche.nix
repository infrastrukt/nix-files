{ config, pkgs, ... }:

{
  systemd.services.fiche = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      User = "http";
      ExecStart = ''
        ${pkgs.fiche}/bin/fiche -d pastespace.org -o /home/http/paste.jeaye.com -l /home/http/fiche.log
      '';
    };
  };

  # Clean up old pastes
  services.cron.systemCronJobs = [
    "0 0 * * * http ${pkgs.findutils}/bin/find /home/http/paste.jeaye.com/* -mtime +14 -type d -exec rm -r {} \\;"
  ];
}