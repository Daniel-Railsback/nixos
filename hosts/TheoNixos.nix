{ config, lib, pkgs, ... }:

{
  imports = [
    ../hosts/hardware-configuration.nix
  ];

  programs.dconf.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "TheoNixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Denver";

  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  users.users.dan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.bashInteractive;
    home = "/home/dan";
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    ghostty
    neovim
    vim
    btop
    pciutils
    wofi
    git
    ripgrep
  ];

  system.stateVersion = "25.05";
}

