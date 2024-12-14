{
  xdg.configFile."hypr/hyprland.conf".text = "
    # Autostart
    exec-once = waybar
    exec-once = mako
    
    # Input configuration
    input {
      kb_layout = us,ru
      kb_options = grp:alt_shift_toggle
      touchpad {
        natural_scroll = true
        tap-to-click = true
      }
    }
    
    # Basic keybindings
    bind = SUPER, Return, exec, foot
    bind = SUPER, Q, killactive
    bind = SUPER, Space, exec, rofi -show drun
    
    # Window management
    bind = SUPER, H, movefocus, l
    bind = SUPER, L, movefocus, r
    bind = SUPER, K, movefocus, u
    bind = SUPER, J, movefocus, d
  ";
}
