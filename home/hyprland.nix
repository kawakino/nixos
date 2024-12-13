# home/hyprland.nix
{ config, pkgs, ... }:

{
  home.file.".config/hypr/hyprland.conf".text = ''
    # Мониторы
    monitor=,preferred,auto,auto
    
    # Автозапуск
    exec-once = waybar
    exec-once = mako
    
    # Переменные окружения
    env = XCURSOR_SIZE,24
    
    # Ввод
    input {
        kb_layout = us,ru
        kb_options = grp:alt_shift_toggle
        follow_mouse = 1
        sensitivity = 0
    }
    
    # Внешний вид
    general {
        gaps_in = 5
        gaps_out = 10
        border_size = 2
        col.active_border = rgba(33ccffee)
        col.inactive_border = rgba(595959aa)
        layout = dwindle
    }
    
    # Украшения
    decoration {
        rounding = 10
        blur = yes
        blur_size = 3
        blur_passes = 1
    }
    
    # Анимации
    animations {
        enabled = yes
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = fade, 1, 7, default
    }
    
    # Раскладка
    dwindle {
        pseudotile = yes
        preserve_split = yes
    }
    
    # Горячие клавиши
    $mainMod = SUPER
    
    bind = $mainMod, RETURN, exec, foot
    bind = $mainMod, Q, killactive,
    bind = $mainMod, M, exit,
    bind = $mainMod, E, exec, dolphin
    bind = $mainMod, V, togglefloating,
    bind = $mainMod, SPACE, exec, rofi -show drun
    bind = $mainMod, P, pseudo,
    bind = $mainMod, J, togglesplit,
    
    # Перемещение фокуса
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d
    
    # Рабочие столы
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    
    # Перемещение окон
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    
    # Мышь
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
  '';
}