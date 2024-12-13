{ config, pkgs, ... }:

{
  imports = [
    ./wayland
    ./programs
    ./cursor.nix    # добавляем новый файл
  ];

  home.stateVersion = "24.11";
}