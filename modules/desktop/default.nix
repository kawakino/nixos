{ config, pkgs, ... }:

{
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Звук
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Автомонтирование USB
  services.udisks2.enable = true;

  # Минимальный набор пакетов
  environment.systemPackages = with pkgs; [
    foot            # Терминал
    rofi-wayland    # Лаунчер
    waybar          # Статус бар
    mako            # Уведомления
    wl-clipboard    # Буфер обмена
    swaylock-effects  # Блокировка экрана
    brightnessctl   # Управление яркостью
    kanshi          # Автоматическое управление мониторами
    wdisplays       # GUI для настройки мониторов
  ];

  # Шрифты (исправленный способ)
  fonts.packages = with pkgs; [
    jetbrains-mono
    (nerdfonts.override { fonts = [ 
      "JetBrainsMono"
      "FiraCode" 
      "Iosevka"
      "VictorMono"
      "Hack"
    ]; })
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  # Переменные окружения
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XCURSOR_SIZE = "24";
  };
}