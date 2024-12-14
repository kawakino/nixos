{ config, pkgs, ... }: {
  users.users.cizen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    shell = pkgs.fish;
  };
}