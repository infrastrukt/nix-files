{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs;
  [
    imapfilter
  ];

  environment.etc =
  {
    "user/jeaye/imap-filter/config.lua" =
    {
      text = lib.readFile ./data/imap-filter-config.lua;
    };
  };

  system.activationScripts =
  {
    jeaye-imap-filter =
    {
      deps = [];
      text =
      ''
        mkdir -p /home/jeaye/{.secret,.imapfilter}
        chown -R jeaye:users /home/jeaye/{.secret,.imapfilter}
        chmod -R 0700 /home/jeaye/.secret
        ln -sf /etc/user/jeaye/imap-filter/config.lua /home/jeaye/.imapfilter/
      '';
      # XXX:
      #   Create pass file in .secret
      #   Run imapfilter once imperatively to accept the SSL cert
    };
  };

  # Run imap-filter regularly
  services.cron.systemCronJobs =
  [
    "*/5 * * * * jeaye ${pkgs.imapfilter}/bin/imapfilter > /dev/null 2>&1"
  ];
}