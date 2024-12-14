{ config, pkgs, ... }: {
  imports = [
    ../default.nix
    ./hardware.nix
  ];

  # Laptop specific services
  services = {
    # Thermal management
    thermald.enable = true;
    
    # Touchpad support
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        scrollMethod = "twofinger";
        disableWhileTyping = true;
      };
    };
  };

  # Power management
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  # Laptop specific packages
  environment.systemPackages = with pkgs; [
    brightnessctl
    acpi
    powertop
  ];
}
