{ config, pkgs, ... }:

{
  home.file.".config/hypr/hyprland.conf".text = ''
    # Мониторы - автоматическое определение
    monitor=,preferred,auto,1

    # Базовые переменные окружения
    env = XCURSOR_SIZE,24
    env = QT_AUTO_SCREEN_SCALE_FACTOR,1
    env = GDK_BACKEND,wayland
    
    # Автозапуск
    exec-once = waybar
    
    # Ввод
    input {
        kb_layout = us,ru
        kb_options = grp:alt_shift_toggle
        follow_mouse = 1
        touchpad {
            natural_scroll = true
            scroll_factor = 0.5
        }
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

    decoration {
        rounding = 8
        blur {
            enabled = true
            size = 3
            passes = 1
        }
    }

    # Мышь и тачпад
    gestures {
        workspace_swipe = true
        workspace_swipe_fingers = 3
    }

    # Разные полезные бинды
    bind = SUPER, RETURN, exec, foot
    bind = SUPER, Q, killactive,
    bind = SUPER, M, exit,
    bind = SUPER, V, togglefloating,
    bind = SUPER, SPACE, exec, rofi -show drun
    bind = SUPER, P, pseudo,
    bind = SUPER, J, togglesplit,

    # Воркспейсы
    bind = SUPER, 1, workspace, 1
    bind = SUPER, 2, workspace, 2
    bind = SUPER, 3, workspace, 3
    bind = SUPER, 4, workspace, 4
    bind = SUPER, 5, workspace, 5

    # Перемещение окон
    bind = SUPER SHIFT, 1, movetoworkspace, 1
    bind = SUPER SHIFT, 2, movetoworkspace, 2
    bind = SUPER SHIFT, 3, movetoworkspace, 3
    bind = SUPER SHIFT, 4, movetoworkspace, 4
    bind = SUPER SHIFT, 5, movetoworkspace, 5
  '';
}