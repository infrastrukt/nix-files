{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./grub.nix
    ./user.nix
    ./x11.nix
    ./browse.nix
    ./dev.nix
  ];

  networking.hostName = "nixos";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Singapore/Singapore";

  environment.systemPackages = with pkgs; [
    wget
    vim
    tmux
    unzip
  ];

  nixpkgs.config.allowUnfree = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Font
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts # MS free fonts
      inconsolata # Monospaced
      terminus_font # The best
      unifont # Some international fonts
    ];
  };

  # Zsh
  programs.zsh.enable = true;

  system.stateVersion = "15.09";
}
