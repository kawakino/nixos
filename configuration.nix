{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./desktop.nix
    ./system.nix
    ./users.nix
    ./networking.nix
    ./packages.nix
    <home-manager/nixos>  # добавьте эту строку
  ];

  # Включаем home-manager
  home-manager.users.cizen = { pkgs, ... }: {
    imports = [ ./home/hyprland.nix ];
    home.stateVersion = "24.11";
  };

  system.stateVersion = "24.11";
}