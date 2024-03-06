{ config, pkgs, lib, ... }: {
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [  ];
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      theme = "Gruvbox Dark";
      font = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
        size = 10;
      };
      settings = {
        background_opacity = "1";
        confirm_os_window_close = "0";
        window_padding_width = "1";
      };
    };
  };
}
