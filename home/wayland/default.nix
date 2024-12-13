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
