{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Отключаем приветствие
      
      # Автозапуск Hyprland на TTY1
      if test (tty) = "/dev/tty1"
        exec Hyprland
      end
    '';
  };
}
