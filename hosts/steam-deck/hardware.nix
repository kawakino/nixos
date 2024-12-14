{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Используем текущую конфигурацию из hardware-configuration.nix
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  # Загрузчик для Steam Deck (использует systemd-boot)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}