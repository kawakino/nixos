{ config, pkgs, ... }:

{
  # Базовый X11 и Wayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    
    # Автоматический вход без DM
    displayManager = {
      autoLogin = {
        enable = true;
        user = "cizen";
      };
      defaultSession = "hyprland";
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

  # Необходимые системные сервисы
  security.polkit.enable = true;

  # Настройка порталов и переменных окружения
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    systemPackages = with pkgs; [
      # Основные утилиты
      xdg-desktop-portal-hyprland
      waybar-hyprland    
      foot               
      rofi-wayland       
      mako              
      swww              
      swaylock-effects  
      wl-clipboard      
      
      # Управление системой
      brightnessctl     
      pamixer           
      
      # Скриншоты
      grim              
      slurp             
      wl-screenrec      

      # Для автоблокировки
      swayidle
    ];
  };
}