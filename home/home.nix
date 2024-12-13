{ config, pkgs, ... }:

{
  home.stateVersion = "23.11";
  
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    nerdfonts  # полный пакет nerdfonts
  ];
}