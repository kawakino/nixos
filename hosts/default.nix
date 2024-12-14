{ config, pkgs, ... }: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Basic hardware support
  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
  };

  # Network management
  networking = {
    networkmanager.enable = true;
  };

  # Basic services
  services = {
    blueman.enable = true;
    fwupd.enable = true;
  };

  # User configuration
  users = {
    users.cizen = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    };
  };

  system.stateVersion = "24.11";
}