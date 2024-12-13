{ config, pkgs, ... }:

{
  imports = [
    ./wayland
    ./programs
  ];

  home.stateVersion = "24.11";
}
