{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Базовые инструменты
    git
    neovim
    
    # Можно добавить вспомогательные инструменты для разработки
    ripgrep  # для быстрого поиска
    fd       # современная замена find
    fzf      # нечеткий поиск
  ];
}