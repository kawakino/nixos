{ config, pkgs, ... }:

{
  home.stateVersion = "23.11";
  
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}