{ config, pkgs, lib, ... }: {
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [ ];
    programs.rofi = {
      enable = true;
      font = "JetBrainsMono Nerd Font 10";
      plugins = with pkgs; [
        rofi-calc
        rofi-top
        rofi-bluetooth
        rofi-pulse-select
        rofi-power-menu
      ];
      theme = "gruvbox-dark";
      extraConfig = {
        modi = "drun,ssh,run";
      };
    };
  };
}
