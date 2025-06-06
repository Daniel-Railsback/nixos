
{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dan";
  home.homeDirectory = "/home/dan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  #Allow home-manager to mess with bash alias
  home.file.".bashrc".force = true;
  #home-manager.backupFileExtension = "hm-backup";

  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  programs.bash = {
   enable = true;
   shellAliases = {
    gs = "git status";
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#TheoNixos";
   };
  }; 
}
