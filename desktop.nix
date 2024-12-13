{ config, pkgs, ... }:

{
  # Включаем X11 и Wayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Звук через pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Базовые компоненты Wayland
  environment.systemPackages = with pkgs; [
    # Основные утилиты
    xdg-desktop-portal-hyprland
    waybar-hyprland    # современный, минималистичный статус бар
    foot               # быстрый и легкий терминал
    rofi-wayland       # продвинутый лаунчер с поддержкой Wayland
    mako              # легкие уведомления для Wayland
    swww              # установка обоев
    swaylock-effects  # красивая блокировка экрана
    wl-clipboard      # буфер обмена
    
    # Управление системой
    brightnessctl     # яркость
    pamixer           # управление звуком из командной строки
    
    # Скриншоты
    grim              # базовый инструмент
    slurp             # выбор области
    wl-screenrec      # запись экрана (легче wf-recorder)
  ];
}