{ config, pkgs, ... }: {
  home.file.".config/waybar/config".text = ''
    // MAIN BAR CONFIGURATION
    {
        // Basic bar properties
        "layer": "bottom",
        "position": "bottom",
        "mod": "dock",
        "exclusive": true,
        "gtk-layer-shell": true,
        "margin-bottom": -1,
        "passthrough": false,
        "height": 41,

        // Module positions
        "modules-left": [
            "custom/os_button",    // Menu button
            "hyprland/workspaces", // Workspace switcher
            "wlr/taskbar"          // Active windows
        ],
        "modules-center": [],
        "modules-right": [
            "cpu",                 // CPU usage
            "temperature",         // CPU temperature
            "memory",             // RAM usage
            "disk",               // Disk usage
            "tray",               // System tray
            "pulseaudio",         // Volume control
            "network",            // Network status
            "battery",            // Battery indicator
            "hyprland/language",  // Keyboard layout
            "clock"               // Time and date
        ],

        // Language switcher configuration
        "hyprland/language": {
            "format": "{}",
            "format-en": "ENG",
            "format-ru": "РУС"
        },

        // Workspaces configuration
        "hyprland/workspaces": {
            "icon-size": 32,
            "spacing": 16,
            "on-scroll-up": "hyprctl dispatch workspace r+1",
            "on-scroll-down": "hyprctl dispatch workspace r-1"
        },

        // Menu button configuration
        "custom/os_button": {
            "format": "",
            "on-click": "wofi --show drun",
            "tooltip": false
        },

        // System monitoring modules
        "cpu": {
            "interval": 5,
            "format": "  {usage}%",
            "max-length": 10
        },
        "temperature": {
            "hwmon-path-abs": "/sys/devices/platform/coretemp.0/hwmon",
            "input-filename": "temp2_input",
            "critical-threshold": 75,
            "tooltip": false,
            "format-critical": "({temperatureC}°C)",
            "format": "({temperatureC}°C)"
        },
        "disk": {
            "interval": 30,
            "format": "󰋊 {percentage_used}%",
            "path": "/",
            "tooltip": true,
            "unit": "GB",
            "tooltip-format": "Available {free} of {total}"
        },
        "memory": {
            "interval": 10,
            "format": "  {percentage}%",
            "max-length": 10,
            "tooltip": true,
            "tooltip-format": "RAM - {used:0.1f}GiB used"
        },

        // Task management
        "wlr/taskbar": {
            "format": "{icon} {title:.17}",
            "icon-size": 28,
            "spacing": 3,
            "on-click-middle": "close",
            "tooltip-format": "{title}",
            "ignore-list": [],
            "on-click": "activate"
        },

        // System tray
        "tray": {
            "icon-size": 18,
            "spacing": 3
        },

        // Clock and calendar
        "clock": {
            "format": "      {:%R\n %d.%m.%Y}",
            "tooltip-format": "<tt><small>{calendar}</small></tt>",
            "calendar": {
                "mode": "year",
                "mode-mon-col": 3,
                "weeks-pos": "right",
                "on-scroll": 1,
                "on-click-right": "mode",
                "format": {
                    "months": "<span color='#ffead3'><b>{}</b></span>",
                    "days": "<span color='#ecc6d9'><b>{}</b></span>",
                    "weeks": "<span color='#99ffdd'><b>W{}</b></span>",
                    "weekdays": "<span color='#ffcc66'><b>{}</b></span>",
                    "today": "<span color='#ff6699'><b><u>{}</u></b></span>"
                }
            },
            "actions": {
                "on-click-right": "mode",
                "on-click-forward": "tz_up",
                "on-click-backward": "tz_down",
                "on-scroll-up": "shift_up",
                "on-scroll-down": "shift_down"
            }
        },

        // Network status
        "network": {
            "format-wifi": " {icon}",
            "format-ethernet": "  ",
            "format-disconnected": "󰌙",
            "format-icons": ["󰤯 ", "󰤟 ", "󰤢 ", "󰤢 ", "󰤨 "]
        },

        // Battery indicator
        "battery": {
            "states": {
                "good": 95,
                "warning": 30,
                "critical": 20
            },
            "format": "{icon} {capacity}%",
            "format-charging": " {capacity}%",
            "format-plugged": " {capacity}%",
            "format-alt": "{time} {icon}",
            "format-icons": ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
        },

        // Volume control
        "pulseaudio": {
            "max-volume": 150,
            "scroll-step": 10,
            "format": "{icon}",
            "tooltip-format": "{volume}%",
            "format-muted": " ",
            "format-icons": {
                "default": [" ", " ", " "]
            },
            "on-click": "pwvucontrol"
        }
    }
  '';

  // CSS STYLING
  home.file.".config/waybar/style.css".text = ''
    /* Base color definitions */
    @define-color bg_main rgba(25, 25, 25, 0.65);
    @define-color bg_main_tooltip rgba(0, 0, 0, 0.7);
    @define-color bg_hover rgba(200, 200, 200, 0.3);
    @define-color bg_active rgba(100, 100, 100, 0.5);
    @define-color border_main rgba(255, 255, 255, 0.2);
    @define-color content_main white;
    @define-color content_inactive rgba(255, 255, 255, 0.25);

    /* Global styles */
    * {
        text-shadow: none;
        box-shadow: none;
        border: none;
        border-radius: 0;
        font-family: "Segoe UI", "Ubuntu";
        font-weight: 600;
        font-size: 12.7px;
    }

    /* Main window styling */
    window#waybar {
        background: @bg_main;
        border-top: 1px solid @border_main;
        color: @content_main;
    }

    /* Tooltip styling */
    tooltip {
        background: @bg_main_tooltip;
        border-radius: 5px;
        border-width: 1px;
        border-style: solid;
        border-color: @border_main;
    }
    tooltip label {
        color: @content_main;
    }

    /* Menu button styling */
    #custom-os_button {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 24px;
        padding-left: 12px;
        padding-right: 20px;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
    }
    #custom-os_button:hover {
        background: @bg_hover;
        color: @content_main;
    }

    /* Workspace buttons styling */
    #workspaces {
        color: transparent;
        margin-right: 1.5px;
        margin-left: 1.5px;
    }
    #workspaces button {
        padding: 3px;
        color: @content_inactive;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
    }
    #workspaces button.active {
        color: @content_main;
        border-bottom: 3px solid white;
    }
    #workspaces button.focused {
        color: @bg_active;
    }
    #workspaces button.urgent {
        background: rgba(255, 200, 0, 0.35);
        border-bottom: 3px dashed @warning_color;
        color: @warning_color;
    }
    #workspaces button:hover {
        background: @bg_hover;
        color: @content_main;
    }

    /* Taskbar styling */
    #taskbar button {
        min-width: 130px;
        border-bottom: 3px solid rgba(255, 255, 255, 0.3);
        margin-left: 2px;
        margin-right: 2px;
        padding-left: 8px;
        padding-right: 8px;
        color: white;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
    }
    #taskbar button.active {
        border-bottom: 3px solid white;
        background: @bg_active;
    }
    #taskbar button:hover {
        border-bottom: 3px solid white;
        background: @bg_hover;
        color: @content_main;
    }

    /* System monitoring modules styling */
    #cpu, #disk, #memory {
        padding: 3px;
    }
    #temperature {
        color: transparent;
        font-size: 0px;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
    }
    #temperature.critical {
        padding-right: 3px;
        color: @warning_color;
        font-size: initial;
        border-bottom: 3px dashed @warning_color;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
    }

    /* System tray styling */
    #tray {
        margin-left: 5px;
        margin-right: 5px;
    }
    #tray > .passive {
        border-bottom: none;
    }
    #tray > .active {
        border-bottom: 3px solid white;
    }
    #tray > .needs-attention {
        border-bottom: 3px solid @warning_color;
    }
    #tray > widget {
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
    }
    #tray > widget:hover {
        background: @bg_hover;
    }

    /* Audio control styling */
    #pulseaudio {
        font-family: "JetBrainsMono Nerd Font";
        padding-left: 3px;
        padding-right: 3px;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
    }
    #pulseaudio:hover {
        background: @bg_hover;
    }

    /* Network, language and clock styling */
    #network {
        padding-left: 3px;
        padding-right: 3px;
    }
    #language {
        padding-left: 5px;
        padding-right: 5px;
    }
    #clock {
        padding-right: 5px;
        padding-left: 5px;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
    }
    #clock:hover {
        background: @bg_hover;
    }
  '';
}