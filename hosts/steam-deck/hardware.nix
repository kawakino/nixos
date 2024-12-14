{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  
  # Add your Steam Deck specific hardware configuration here
}
