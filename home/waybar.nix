{ config, pkgs, ... }:

{
  home.file.".config/waybar/config".text = ''
    {
        "layer": "top",
        "position": "top",
        "height": 30,
        "modules-left": ["hyprland/workspaces"],
        "modules-center": ["clock"],
        "modules-right": ["pulseaudio"],
        
        "clock": {
            "format": "{:%H:%M}"
        },
        
        "pulseaudio": {
            "format": "{volume}%"
        }
    }
  '';

  home.file.".config/waybar/style.css".text = ''
    * {
        font-family: "JetBrains Mono Nerd Font";
        font-size: 13px;
    }

    window#waybar {
        background: #1e1e2e;
        color: #ffffff;
    }
  '';
}