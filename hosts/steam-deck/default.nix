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
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
    };
  };

  # Steam Deck controller support
  services.udev.extraRules = 
