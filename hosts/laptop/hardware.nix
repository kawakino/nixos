{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  
  # Add your laptop specific hardware configuration here
}
