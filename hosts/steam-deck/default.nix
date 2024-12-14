{ config, pkgs, ... }: {
  imports = [
    ../default.nix
    ./hardware.nix
  ];

  # Steam Deck specific hardware support
  hardware = {
    steam-hardware.enable = true;
    
    # AMD graphics for Steam Deck
    opengl = {
      enable = true;
      # Удалили driSupport так как он больше не нужен
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
    };
  };

  # Steam Deck controller support
  services.udev.extraRules = ''
    # Steam Deck Controller
    SUBSYSTEM=="input", ATTRS{name}=="*Steam Deck*", MODE="0666"
    KERNEL=="uinput", SUBSYSTEM=="misc", MODE="0660", GROUP="input"
  '';

  # Steam Deck specific packages
  environment.systemPackages = with pkgs; [
    steam
    gamescope
    mangohud
  ];

  # Performance tweaks for gaming
  boot.kernelParams = [
    "amd_pstate=active"
    "processor.energy_perf_bias=performance"
  ];
}