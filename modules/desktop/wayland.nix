{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    foot
    rofi-wayland
    waybar
    mako
    wl-clipboard
    swaylock-effects
    brightnessctl
  ];
}