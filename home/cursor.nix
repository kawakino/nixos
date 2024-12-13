{ config, pkgs, ... }: {
  home.pointerCursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
  };
}