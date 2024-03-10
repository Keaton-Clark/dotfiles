{ lib, config, pkgs, inputs, ... }: {
  imports = [
    ./zsh.nix
    ./tmux.nix
  ];
  environment.systemPackages = [
      inputs.self.packages.x86_64-linux.neovim
  ];
  home-manager.users.${config.user} = {
    programs.git = {
      enable = true;
      userEmail = config.email;
      userName = config.fullName;
    };
  };
}
