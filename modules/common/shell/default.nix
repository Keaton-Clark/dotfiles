{ lib, config, pkgs, inputs, ... }: {
  imports = [
    ./zsh.nix
    ./tmux.nix
  ];
  config.environment.systemPackages = [
      inputs.self.packages.x86_64-linux.neovim
  ];
}
