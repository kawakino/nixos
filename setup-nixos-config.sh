#!/usr/bin/env bash

# Create base directories
mkdir -p {hosts/default,modules/{core,desktop,hardware},home/{programs,wayland}}

# Function to create file with content
create_file() {
    mkdir -p "$(dirname "$1")"
    echo "$2" > "$1"
    echo "Created: $1"
}

# Create flake.nix
create_file "flake.nix" '{
  description = "Minimal NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.cizen = import ./home;
        }
      ];
    };
  };
}'

# Create configuration.nix
create_file "configuration.nix" '{
  imports = [
    ./hardware-configuration.nix
    ./modules/core
    ./modules/desktop
    ./modules/hardware
  ];

  system.stateVersion = "24.11";
}'

# Create core modules
create_file "modules/core/default.nix" '{
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
}'

create_file "modules/core/nix.nix" '{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  
  nixpkgs.config.allowUnfree = true;
}'

create_file "modules/core/boot.nix" '{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}'

create_file "modules/core/users.nix" '{
  users.users.cizen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    shell = pkgs.fish;
  };
}'

create_file "modules/core/networking.nix" '{
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };
}'

# Create desktop modules
create_file "modules/desktop/default.nix" '{
  imports = [
    ./hyprland.nix
    ./wayland.nix
    ./fonts.nix
  ];
}'

create_file "modules/desktop/hyprland.nix" '{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };
}'

create_file "modules/desktop/wayland.nix" '{
  environment.systemPackages = with pkgs; [
    foot
    rofi-wayland
    waybar
    mako
    wl-clipboard
    swaylock-effects
    brightnessctl
  ];
}'

create_file "modules/desktop/fonts.nix" '{
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts
    noto-fonts
    noto-fonts-emoji
  ];
}'

# Create hardware modules
create_file "modules/hardware/default.nix" '{
  imports = [
    ./laptop.nix
  ];
}'

create_file "modules/hardware/laptop.nix" '{
  services.thermald.enable = true;
  powerManagement.enable = true;

  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      scrollMethod = "twofinger";
    };
  };
}'

# Create home-manager configurations
create_file "home/default.nix" '{
  imports = [
    ./programs
    ./wayland
  ];

  home.stateVersion = "24.11";
}'

create_file "home/programs/default.nix" '{
  imports = [
    ./fish.nix
  ];
}'

create_file "home/programs/fish.nix" '{
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
}'

create_file "home/wayland/default.nix" '{
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];
}'

create_file "home/wayland/hyprland.nix" '{
  xdg.configFile."hypr/hyprland.conf".text = "
    # Autostart
    exec-once = waybar
    exec-once = mako
    
    # Input configuration
    input {
      kb_layout = us,ru
      kb_options = grp:alt_shift_toggle
      touchpad {
        natural_scroll = true
        tap-to-click = true
      }
    }
    
    # Basic keybindings
    bind = SUPER, Return, exec, foot
    bind = SUPER, Q, killactive
    bind = SUPER, Space, exec, rofi -show drun
    
    # Window management
    bind = SUPER, H, movefocus, l
    bind = SUPER, L, movefocus, r
    bind = SUPER, K, movefocus, u
    bind = SUPER, J, movefocus, d
  ";
}'

create_file "home/wayland/waybar.nix" '{
  xdg.configFile."waybar/config".text = "{
    \"layer\": \"top\",
    \"position\": \"top\",
    \"modules-left\": [\"hyprland/workspaces\"],
    \"modules-center\": [\"clock\"],
    \"modules-right\": [\"pulseaudio\", \"network\", \"tray\"]
  }";
}'

chmod +x setup-nixos-config.sh
echo "NixOS configuration structure has been created!"