{ config, pkgs, ... }:

{
  # Тачпад
  services.xserver.libinput = {
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
