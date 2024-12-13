{ config, pkgs, ... }:

{
    home.file.".config/hypr/hyprland.conf".text = ''
    # В начале конфигурации
    exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    
    # Затем уже автозапуск
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

    # Выход из Hyprland
    bind = SUPER, M, exit

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
    # Vim-подобная навигация
    bind = SUPER, H, movefocus, l
    bind = SUPER, L, movefocus, r
    bind = SUPER, K, movefocus, u
    bind = SUPER, J, movefocus, d
    
    # Перемещение окон (vim-style)
    bind = SUPER SHIFT, H, movewindow, l
    bind = SUPER SHIFT, L, movewindow, r
    bind = SUPER SHIFT, K, movewindow, u
    bind = SUPER SHIFT, J, movewindow, d
    
    # Изменение размера окон
    bind = SUPER ALT, H, resizeactive, -20 0
    bind = SUPER ALT, L, resizeactive, 20 0
    bind = SUPER ALT, K, resizeactive, 0 -20
    bind = SUPER ALT, J, resizeactive, 0 20
    
    # Дополнительные удобные бинды
    bind = SUPER, V, togglefloating
    bind = SUPER, P, pseudo # dwindle
    bind = SUPER, E, togglesplit # dwindle
    
    # Двигаем окна мышкой с SUPER
    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow
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
    "spacing": 4,
    "height": 35,
    "modules-left": ["hyprland/workspaces", "custom/media"],
    "modules-center": ["clock"],
    "modules-right": ["backlight", "pulseaudio", "network", "battery", "custom/power", "tray"],

    "hyprland/workspaces": {
        "format": "{name}",
        "on-click": "activate",
        "format-icons": {
            "1": "",
            "2": "",
            "3": "",
            "4": "",
            "5": "",
            "urgent": "",
            "active": "",
            "default": ""
        },
        "sort-by-number": true
    },

    "clock": {
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "format": "{:%H:%M}",
        "format-alt": "{:%Y-%m-%d}"
    },

    "battery": {
        "states": {
            "good": 95,
            "warning": 30,
            "critical": 15
        },
        "format": "{capacity}% {icon}",
        "format-charging": "{capacity}% ",
        "format-plugged": "{capacity}% ",
        "format-alt": "{time} {icon}",
        "format-icons": ["", "", "", "", ""]
    },

    "network": {
        "format-wifi": "{essid} ({signalStrength}%) ",
        "format-ethernet": "Connected  ",
        "tooltip-format": "{ifname} via {gwaddr} ",
        "format-linked": "{ifname} (No IP) ",
        "format-disconnected": "Disconnected ⚠",
        "format-alt": "{ifname}: {ipaddr}/{cidr}"
    },

    "pulseaudio": {
        "format": "{volume}% {icon}",
        "format-bluetooth": "{volume}% {icon}",
        "format-bluetooth-muted": " {icon}",
        "format-muted": " ",
        "format-icons": {
            "headphone": "",
            "hands-free": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", "", ""]
        },
        "on-click": "pavucontrol"
    },

    "backlight": {
        "format": "{percent}% {icon}",
        "format-icons": ["", "", "", "", "", "", "", "", ""],
        "on-scroll-up": "brightnessctl set +5%",
        "on-scroll-down": "brightnessctl set 5%-"
    },

    "custom/power": {
        "format": "⏻",
        "on-click": "rofi -show power-menu -modi power-menu:~/.local/bin/rofi-power-menu"
    },

    "tray": {
        "icon-size": 18,
        "spacing": 10
    }
}
'';

home.file.".config/waybar/style.css".text = ''
* {
    border: none;
    border-radius: 0;
    font-family: "JetBrainsMono Nerd Font", "Roboto Mono", sans-serif;
    font-weight: bold;
    font-size: 14px;
    min-height: 0;
}

window#waybar {
    background: rgba(21, 18, 27, 0);
    color: #cdd6f4;
}

tooltip {
    background: #1e1e2e;
    border-radius: 10px;
    border-width: 2px;
    border-style: solid;
    border-color: #11111b;
}

#workspaces button {
    padding: 5px;
    color: #313244;
    margin-right: 5px;
}

#workspaces button.active {
    color: #a6adc8;
    background: #eba0ac;
    border-radius: 10px;
}

#workspaces button:hover {
    background: #11111b;
    color: #cdd6f4;
    border-radius: 10px;
}

#custom/power,
#clock,
#battery,
#pulseaudio,
#network,
#workspaces,
#tray,
#backlight {
    background: #1e1e2e;
    padding: 0px 10px;
    margin: 3px 0px;
    margin-top: 10px;
    border: 1px solid #181825;
}

#custom/power {
    color: #e66465;
    border-radius: 10px;
    margin-right: 10px;
    padding: 0 15px;
}

#clock {
    color: #fab387;
    border-radius: 10px;
    margin-left: 10px;
    margin-right: 10px;
}

#network {
    color: #f9e2af;
    border-radius: 10px 0px 0px 10px;
    border-left: 0px;
    margin-left: 10px;
}

#pulseaudio {
    color: #89b4fa;
    border-radius: 0px 10px 10px 0px;
    margin-right: 10px;
}

#battery {
    color: #a6e3a1;
    border-radius: 10px;
    margin-right: 10px;
}

#battery.charging, #battery.plugged {
    color: #94e2d5;
}

#battery.critical:not(.charging) {
    background-color: #f38ba8;
    color: #1e1e2e;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

@keyframes blink {
    to {
        background-color: #1e1e2e;
        color: #f38ba8;
    }
}

#backlight {
    color: #cba6f7;
    border-radius: 10px;
    margin-right: 10px;
}

#tray {
    border-radius: 10px;
    margin-right: 10px;
}

#workspaces {
    background: #1e1e2e;
    border-radius: 10px;
    margin-left: 10px;
    padding-right: 0px;
    padding-left: 5px;
}
'';

  home.file.".config/foot/foot.ini".text = ''
  # Можете переключаться между этими шрифтами, чтобы выбрать любимый
  #font=JetBrainsMono Nerd Font:size=11
  #font=FiraCode Nerd Font:size=11
  #font=Iosevka Nerd Font:size=11
  font=VictorMono Nerd Font:size=11
  #font=Hack Nerd Font:size=11

  pad=10x10

  [colors]
  alpha=0.95
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
