{
  programs.fish = {
    enable = true;
    interactiveShellInit = "
      set fish_greeting # Disable greeting
      
      # Autostart Hyprland on TTY1
      if test (tty) = \"/dev/tty1\"
        exec Hyprland
      end
    ";
  };
}
