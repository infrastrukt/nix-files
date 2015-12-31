{ config, pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix # Auto-generated by nixos
    ./nixos-in-place.nix

    ./system/grub.nix
    ./system/environment.nix
    ./system/network.nix
    ./system/user.nix
    ./system/systemd.nix

    ./program/vim.nix
    ./program/irc.nix
    ./program/usenet.nix
    ./program/admin.nix

    ./service/ssh.nix
    ./service/acme.nix
    ./service/httpd.nix
    ./service/postfix.nix
    ./service/dovecot.nix
    ./service/opendkim.nix
    ./service/fiche.nix
    ./service/fail2ban.nix
    ./service/imap-filter.nix
  ];

  system.stateVersion = "15.09";
}
