{ config, pkgs, ... }: {
  imports = [
    ./nix.nix
    ./boot.nix
    ./users.nix
    ./networking.nix
  ];

  # Basic system settings
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  # Essential packages
  environment.systemPackages = with pkgs; [
    git neovim wget ripgrep fd
  ];
}