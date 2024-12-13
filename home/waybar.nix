{ config, pkgs, ... }:

{
  home.file.".config/waybar/config".text = ''
    {
      "layer": "top",
      "position": "top",
      "height": 30,
      "modules-left": ["hyprland/workspaces"],
      "modules-center": ["clock"],
      "modules-right": ["pulseaudio", "network", "battery"],
      
      "clock": {
        "format": "{:%H:%M}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"
      },
      "battery": {
        "states": {
          "warning": 30,
          "critical": 15
        },
        "format": "{capacity}% {icon}",
        "format-charging": "{capacity}% ",
        "format-plugged": "{capacity}% ",
        "format-icons": ["", "", "", "", ""]
      },
      "network": {
        "format-wifi": "{essid} ({signalStrength}%) ",
        "format-ethernet": "{ipaddr}/{cidr} ",
        "tooltip-format": "{ifname} via {gwaddr} ",
        "format-linked": "{ifname} (No IP) ",
        "format-disconnected": "Disconnected ⚠",
        "format-alt": "{ifname}: {ipaddr}/{cidr}"
      },
      "pulseaudio": {
        "format": "{volume}% {icon} {format_source}",
        "format-bluetooth": "{volume}% {icon} {format_source}",
        "format-bluetooth-muted": " {icon} {format_source}",
        "format-muted": " {format_source}",
        "format-source": "{volume}% ",
        "format-source-muted": "",
        "format-icons": {
          "headphone": "",
          "hands-free": "",
          "headset": "",
          "phone": "",
          "portable": "",
          "car": "",
          "default": ["", "", ""]
        }
      }
    }
  '';

  home.file.".config/waybar/style.css".text = ''
    * {
      border: none;
      border-radius: 0;
      font-family: "JetBrainsMono Nerd Font";
      font-size: 13px;
      min-height: 0;
    }

    window#waybar {
      background: rgba(21, 18, 27, 0.9);
      color: #cdd6f4;
    }

    #workspaces button {
      padding: 0 5px;
      color: #313244;
      background: transparent;
    }

    #workspaces button.active {
      color: #a6adc8;
      background: #313244;
      border-radius: 0px;
    }
  '';
}