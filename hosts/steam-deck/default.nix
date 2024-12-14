{ config, pkgs, ... }: {
  imports = [
    ../default.nix
    ./hardware.nix
  ];

  # Минимальные настройки Jovian только для железа Steam Deck
  jovian = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;  # Для Remote Play
      autoStart = false;  # Отключаем автозапуск
    };
    devices.steamdeck = {
      enable = true;  # Поддержка железа Steam Deck
      # Отключаем настройки рабочего стола, так как используем Hyprland
      noDisplay = true;
    };
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