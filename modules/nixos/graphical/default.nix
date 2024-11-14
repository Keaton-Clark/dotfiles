{ config, pkgs, lib, ... }: {
  imports = [
    ./hyprland.nix ./kitty.nix ./xorg.nix ./polybar.nix ./rofi.nix ./chrome.nix ./grobi.nix ./gtk.nix ./discord.nix ./ags ./virtualbox.nix
  ];
  config = {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        zathura
        gimp
      ];
    };
  };
}

