{ config, pkgs, ... }: {
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrainsmono
    noto-fonts
    noto-fonts-emoji
  ];
}