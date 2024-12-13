{ config, pkgs, ... }:

{
  # Базовые настройки системы
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  
  # Разрешаем unfree пакеты
  nixpkgs.config.allowUnfree = true;

  # Загрузчик
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Сеть
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  # SSH для удаленной настройки
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;  # Для начальной настройки
      PermitRootLogin = "no";
    };
  };

  # Локализация
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  # Пользователь
  users.users.cizen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    shell = pkgs.fish;
  };

  # Включаем fish
  programs.fish.enable = true;

  # Базовые пакеты
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    ripgrep
    fd
  ];
}
