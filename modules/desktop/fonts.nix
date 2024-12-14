{ config, pkgs, ... }: {
  fonts.packages = with pkgs; [
    jetbrains-mono
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "Hack" ]; })
    noto-fonts
    noto-fonts-emoji
  ];
}