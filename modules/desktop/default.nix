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
    foot            
    rofi-wayland    
    waybar          
    mako            
    wl-clipboard    
    swaylock-effects  
    brightnessctl   
    kanshi          
    wdisplays       
    gtk3            # добавляем
    libgcc          # добавляем
];

# Добавляем поддержку GTK
programs.waybar = {
  enable = true;
  package = pkgs.waybar;
};

# Добавляем переменные окружения для Wayland
environment.sessionVariables = {
  NIXOS_OZONE_WL = "1";
  WLR_NO_HARDWARE_CURSORS = "1";
  XCURSOR_SIZE = "24";
  # Добавляем эти переменные
  XDG_CURRENT_DESKTOP = "Hyprland";
  XDG_SESSION_TYPE = "wayland";
  XDG_SESSION_DESKTOP = "Hyprland";
};

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.victor-mono
    nerd-fonts.hack
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
}