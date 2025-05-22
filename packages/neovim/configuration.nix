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
      updatetime = 250;
      colorcolumn = "120";
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
      direnv
    ];
    globals = {
      mapleader = " ";
    };
    extraConfigLuaPost = ''
      require('dap').adapters.cppdbg = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" },
      }
    '';
  };
}
