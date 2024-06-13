{ lib, config, pkgs, inputs, ... }: {
  imports = [
    ./zsh.nix
    ./tmux.nix
  ];
  environment.systemPackages = [
      inputs.self.packages.x86_64-linux.neovim
      pkgs.rofi-menugen
      pkgs.jq
      pkgs.socat
  ];
  home-manager.users.${config.user} = {
    programs.git = {
      enable = true;
      userEmail = config.email;
      userName = config.fullName;
    };
  };
}
