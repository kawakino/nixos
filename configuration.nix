{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./desktop.nix
    ./system.nix
    ./users.nix
    ./networking.nix
  ];

  system.stateVersion = "24.11";
}