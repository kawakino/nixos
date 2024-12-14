{
  imports = [
    ./nix.nix
    ./boot.nix
    ./users.nix
    ./networking.nix
  ];

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    git neovim wget ripgrep fd
  ];
}
