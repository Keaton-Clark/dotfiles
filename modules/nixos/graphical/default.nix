{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./hyprland.nix
    ./kitty.nix
    ./xorg.nix
    ./polybar.nix
    ./rofi.nix
    ./chrome.nix
    ./gtk.nix
    ./discord.nix
    ./ags
    ./virtualbox.nix
  ];
  config = {
    home-manager.users.${config.user} = {
      imports = [
        inputs.nix-colors.homeManagerModules.default
      ];
      colorScheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-hard;
      home.packages = with pkgs; [
        zathura
        gimp
      ];
    };
  };
}

