{ config, pkgs, ... }: {
  # Basic hardware support
  hardware = {
    enableAllFirmware = true;
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
      wifi.backend = "iwd"; # Modern WiFi backend
    };
  };

  # Basic services
  services = {
    # Bluetooth GUI
    blueman.enable = true;
    # Firmware updates
    fwupd.enable = true;
    # Power management
    power-profiles-daemon.enable = true;
    # Better than tlp for modern devices
    auto-cpufreq.enable = true;
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
