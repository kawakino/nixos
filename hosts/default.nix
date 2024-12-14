{ config, pkgs, ... }: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # State version
  system.stateVersion = "24.11";

  # Basic hardware support
  hardware = {
    enableRedistributableFirmware = true;  # Вместо enableAllFirmware
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };

  # Network management
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  # Basic services
  services = {
    blueman.enable = true;
    fwupd.enable = true;
    # Используем только power-profiles-daemon
    power-profiles-daemon.enable = true;
  };

  # User configuration
  users = {
    users.cizen = {
      isNormalUser = true;
      group = "cizen";
      extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    };
    groups.cizen = {};
  };

  # Common packages
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    bluez
    bluez-tools
    usbutils
    pciutils
  ];
}