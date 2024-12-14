{ config, pkgs, ... }: {
  imports = [
    ../default.nix
    ./hardware.nix
  ];

  # Базовые настройки Jovian
  jovian = {
    steam.enable = true;
    devices.steamdeck.enable = true;
  };

  # Необходимые пакеты для игр
  environment.systemPackages = with pkgs; [
    steam
    steam-run      # Помощник для запуска Steam игр
    gamescope      # Композитор для игр
    mangohud       # Оверлей с производительностью
    protonup-qt    # Менеджер версий Proton
  ];

  # Переменные окружения для Steam в Wayland
  environment.sessionVariables = {
    STEAM_USE_GAMESCOPE = "1";
    GAMESCOPE_ENABLE_FSR = "1";
  };
}