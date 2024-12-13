{ config, pkgs, ... }:

{
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