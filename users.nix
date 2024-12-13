{ config, pkgs, ... }:

{
  users.users.cizen = {
    isNormalUser = true;
    description = "cizen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # пользовательские пакеты
    ];
    # Автозапуск Hyprland при входе в TTY1
    shell = pkgs.fish;  # если используете fish, если bash - уберите эту строку
  };

  programs.fish.loginShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec Hyprland
    end
  '';  # для bash используйте programs.bash.loginShellInit
}