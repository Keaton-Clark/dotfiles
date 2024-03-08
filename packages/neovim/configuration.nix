{ pkgs, ... }:
{
  config = {
    colorschemes.gruvbox.enable = true;
    viAlias = true;
    options = {
      number = true;
      wrap = false;
      relativenumber = true;
      cursorline = true;
    };
    extraPackages = with pkgs; [
      ripgrep
    ];
    globals = {
      mapleader = " ";
    };
  };
}
