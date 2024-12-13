{ config, pkgs, ... }:

{
  users.users.cizen = {
    isNormalUser = true;
    description = "cizen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # пользовательские пакеты
    ];
  };
}