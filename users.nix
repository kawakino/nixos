{ config, pkgs, ... }:

{
  users.users.cizen = {
    isNormalUser = true;
    description = "cizen";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      # пользовательские пакеты
    ];
  };

  # Включаем fish
  programs.fish = {
    enable = true;
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]
        exec Hyprland
      end
    '';
  };
}