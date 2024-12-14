{ config, pkgs, ... }: {

  services.thermald.enable = true;
  powerManagement.enable = true;

  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      scrollMethod = "twofinger";
    };
  };
}
