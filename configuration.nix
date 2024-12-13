{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ./hardware-configuration.nix
    ./desktop.nix
    ./system.nix
    ./users.nix
    ./networking.nix
    ./packages.nix
  ];


  system.stateVersion = "24.11";
}