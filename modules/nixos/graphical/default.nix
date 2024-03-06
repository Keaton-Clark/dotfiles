{ config, pkgs, lib, ... }: {
  imports = [
    ./kitty.nix ./i3.nix ./xorg.nix ./polybar.nix ./rofi.nix ./chrome.nix ./grobi.nix ./gtk.nix
  ];
  config = {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        zathura
      ];
    };
  };
}

