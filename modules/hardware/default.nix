{ config, pkgs, ... }:

{
  # Тачпад (исправленные опции)
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      scrollMethod = "twofinger";
    };
  };

  # Управление питанием
  services.thermald.enable = true;
  powerManagement.enable = true;
}