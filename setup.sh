#!/bin/bash

# Создаем структуру директорий
mkdir -p {modules/{core,desktop,hardware},home/{wayland,programs}}

# Создаем все необходимые файлы
cat > flake.nix << 'EOF'
{
  description = "Минималистичная NixOS конфигурация";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.cizen = import ./home;
          }
        ];
      };
    };
}
EOF

cat > configuration.nix << 'EOF'
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/core
    ./modules/desktop
    ./modules/hardware
  ];

  system.stateVersion = "24.11";
}
EOF

cat > modules/core/default.nix << 'EOF'
{ config, pkgs, ... }:

{
  # Базовые настройки системы
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  
  # Разрешаем unfree пакеты
  nixpkgs.config.allowUnfree = true;

  # Загрузчик
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Сеть
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  # SSH для удаленной настройки
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;  # Для начальной настройки
      PermitRootLogin = "no";
    };
  };

  # Локализация
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  # Пользователь
  users.users.cizen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    shell = pkgs.fish;
  };

  # Включаем fish
  programs.fish.enable = true;

  # Базовые пакеты
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    ripgrep
    fd
  ];
}
EOF

cat > modules/desktop/default.nix << 'EOF'
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

  # Шрифты
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Переменные окружения
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XCURSOR_SIZE = "24";
  };
}
EOF

cat > modules/hardware/default.nix << 'EOF'
{ config, pkgs, ... }:

{
  # Тачпад
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      scrollMethod = "twofinger";
    };
  };

  # Управление питанием
  services.thermald.enable = true;
  powerManagement.enable = true;
}
EOF

cat > home/default.nix << 'EOF'
{ config, pkgs, ... }:

{
  imports = [
    ./wayland
    ./programs
  ];

  home.stateVersion = "24.11";
}
EOF

cat > home/wayland/default.nix << 'EOF'
{ config, pkgs, ... }:

{
  home.file.".config/hypr/hyprland.conf".text = ''
    # Автозапуск
    exec-once = waybar
    exec-once = mako
    exec-once = kanshi

    # Ввод
    input {
        kb_layout = us,ru
        kb_options = grp:alt_shift_toggle
        touchpad {
            natural_scroll = true
            tap-to-click = true
        }
    }

    # Внешний вид
    general {
        gaps_in = 3
        gaps_out = 6
        border_size = 2
        col.active_border = rgba(33ccffee)
        layout = dwindle
    }

    # Жесты
    gestures {
        workspace_swipe = true
        workspace_swipe_fingers = 3
    }

    # Бинды
    bind = SUPER, Return, exec, foot
    bind = SUPER, Q, killactive
    bind = SUPER, Space, exec, rofi -show drun
    bind = SUPER, L, exec, swaylock
    bind = SUPER, F, fullscreen
    
    # Воркспейсы
    bind = SUPER, 1, workspace, 1
    bind = SUPER, 2, workspace, 2
    bind = SUPER, 3, workspace, 3
    bind = SUPER, 4, workspace, 4

    # Перемещение окон
    bind = SUPER SHIFT, 1, movetoworkspace, 1
    bind = SUPER SHIFT, 2, movetoworkspace, 2
    bind = SUPER SHIFT, 3, movetoworkspace, 3
    bind = SUPER SHIFT, 4, movetoworkspace, 4

    # Управление звуком и яркостью
    bindel = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    bindel = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindel = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = , XF86MonBrightnessUp, exec, brightnessctl s +5%
    bindel = , XF86MonBrightnessDown, exec, brightnessctl s 5%-
  '';

  home.file.".config/kanshi/config".text = ''
    profile {
      output "*" enable
    }
  '';

  home.file.".config/waybar/config".text = ''
    {
        "layer": "top",
        "position": "top",
        "height": 30,
        "modules-left": ["hyprland/workspaces"],
        "modules-center": ["clock"],
        "modules-right": ["battery", "pulseaudio", "network", "tray"],
        
        "clock": {
            "format": "{:%H:%M}"
        },
        
        "battery": {
            "format": "{capacity}% {icon}",
            "format-icons": ["", "", "", "", ""],
            "states": {
                "warning": 30,
                "critical": 15
            }
        },
        
        "network": {
            "format-wifi": "{essid} ",
            "format-ethernet": "",
            "format-disconnected": "⚠"
        },
        
        "pulseaudio": {
            "format": "{volume}% {icon}",
            "format-muted": "",
            "format-icons": {
                "default": ["", "", ""]
            }
        },
        
        "tray": {
            "icon-size": 16,
            "spacing": 10
        }
    }
  '';

  home.file.".config/waybar/style.css".text = ''
    * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
    }

    window#waybar {
        background: rgba(30, 30, 46, 0.9);
        color: #ffffff;
    }

    #workspaces button {
        padding: 0 5px;
        color: #ffffff;
    }

    #workspaces button.active {
        background: #33ccff;
        color: #000000;
    }

    #clock,
    #battery,
    #network,
    #pulseaudio,
    #tray {
        padding: 0 10px;
    }
  '';

  home.file.".config/foot/foot.ini".text = ''
    font=JetBrainsMono Nerd Font:size=11
    pad=10x10
  '';

  home.file.".config/mako/config".text = ''
    sort=-time
    layer=overlay
    background-color=#2e3440
    width=300
    height=110
    border-size=2
    border-color=#88c0d0
    border-radius=5
    margin=5
    padding=10
    default-timeout=5000
    
    [urgency=high]
    border-color=#bf616a
    default-timeout=0
  '';
}
EOF

cat > home/programs/default.nix << 'EOF'
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
EOF