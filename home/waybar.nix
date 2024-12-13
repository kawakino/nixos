{ config, pkgs, ... }:

{
  home.file.".config/waybar/config".text = ''
    {
        "layer": "top",
        "position": "top",
        "modules-left": ["hyprland/workspaces"],
        "modules-center": ["clock"],
        "modules-right": ["pulseaudio", "network", "cpu", "memory", "battery"],
        
        "clock": {
            "format": "{:%H:%M}",
            "tooltip": true,
            "tooltip-format": "{:%Y-%m-%d}"
        },
        
        "network": {
            "format-wifi": " {essid}",
            "format-ethernet": "󰈀 Connected",
            "format-disconnected": "󰈂 Disconnected",
            "tooltip-format": "{ifname} via {gwaddr}"
        },
        
        "pulseaudio": {
            "format": "{icon} {volume}%",
            "format-muted": "󰝟",
            "format-icons": {
                "default": ["", "", ""]
            }
        },

        "cpu": {
            "format": " {usage}%",
            "tooltip": false
        },

        "memory": {
            "format": "󰍛 {}%"
        },

        "battery": {
            "format": "{icon} {capacity}%",
            "format-icons": ["", "", "", "", ""]
        }
    }
  '';

  home.file.".config/waybar/style.css".text = ''
    * {
        font-family: "JetBrains Mono Nerd Font";
        font-size: 13px;
        min-height: 0;
    }

    window#waybar {
        background: rgba(30, 30, 46, 0.95);
        color: #cdd6f4;
    }

    #workspaces button {
        padding: 0 5px;
        margin: 4px 3px;
        background: transparent;
        color: #cdd6f4;
        border-radius: 4px;
        transition: all 0.3s ease;
    }

    #workspaces button.active {
        background: #313244;
        color: #cdd6f4;
    }

    #clock,
    #battery,
    #cpu,
    #memory,
    #network,
    #pulseaudio {
        padding: 0 10px;
        margin: 4px 2px;
        background: #313244;
        border-radius: 4px;
    }

    #battery.charging {
        color: #a6e3a1;
    }

    #battery.warning:not(.charging) {
        color: #f38ba8;
    }
  '';
}