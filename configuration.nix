{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/core
    ./modules/desktop
    ./modules/hardware
  ];

  system.stateVersion = "24.11";
}
