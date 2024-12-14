{ config, pkgs, ... }: {
  imports = [
    ../default.nix
    ./hardware.nix
  ];

  # Включаем поддержку Jovian
  jovian = {
    steam.enable = true;           # Базовая поддержка Steam
    devices.steamdeck.enable = true; # Специфичные настройки Steam Deck
    decky-loader.enable = true;     # Опционально: поддержка Decky Loader
  };

  # Дополнительные пакеты если нужны
  environment.systemPackages = with pkgs; [
    mangohud
  ];
}