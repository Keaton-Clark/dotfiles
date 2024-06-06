{ pkgs, ... }:
{
  config = {
    colorschemes.gruvbox.enable = true;
    viAlias = true;
    vimAlias = true;
    options = {
      number = true;
      wrap = false;
      relativenumber = true;
      cursorline = true;
      updatetime = 250;
    };
    autoCmd = [
      {
        event = [ "CursorHold" "CursorHoldI" ];
        pattern = [ "*" ];
        command = "lua vim.diagnostic.open_float(nil, {focus=false})";
      }
    ];
    extraPackages = with pkgs; [
      ripgrep
    ];
    globals = {
      mapleader = " ";
    };
  };
}
