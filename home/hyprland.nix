{ config, pkgs, ... }:

{
  home.file.".config/hypr/hyprland.conf".text = ''
    # Мониторы
    monitor=,1920x1080@60,auto,1

    # Автозапуск
    exec-once = waybar

    # Переменные окружения
    env = XCURSOR_SIZE,24
    env = GDK_SCALE,1
    
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