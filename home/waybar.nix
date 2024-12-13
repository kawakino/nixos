{ config, pkgs, ... }:

{
  home.file.".config/waybar/config".text = ''
    {
        "layer": "top",
        "position": "top",
        "height": 30,
        "modules-left": ["hyprland/workspaces"],
        "modules-center": ["clock"],
        "modules-right": ["pulseaudio", "network"],
        
        "clock": {
            "format": "{:%H:%M}"
        },
        
        "network": {
            "format-wifi": "{essid}",
            "format-ethernet": "{ipaddr}",
            "format-disconnected": "Disconnected"
        },
        
        "pulseaudio": {
            "format": "{volume}%",
            "format-muted": "Muted"
        }
    }
  '';

  home.file.".config/waybar/style.css".text = ''
    * {
        font-family: JetBrains Mono Nerd Font;
        font-size: 13px;
    }

    window#waybar {
        background: #1e1e2e;
        color: #ffffff;
    }

    #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: #ffffff;
    }

    #workspaces button.active {
        background: #313244;
        color: #ffffff;
    }
  '';
}