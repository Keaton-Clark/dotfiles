{ lib, config, pkgs, inputs, ... }: {
  imports = [
    ./zsh.nix
    ./tmux.nix
  ];
  environment.systemPackages = [
      inputs.self.packages.x86_64-linux.neovim
      pkgs.comma
      pkgs.man-pages
      pkgs.man-pages-posix
      pkgs.jq
      pkgs.fzf
  ];
  home-manager.users.${config.user} = {
    programs.git = {
      enable = true;
      userEmail = config.email;
      userName = config.fullName;
      extraConfig = {
        url = {
          "ssh://git@bitbucket.org/" = {
            insteadOf = "https://bitbucket.org/";
          };
        };
      };
    };
    programs.gh = {
      enable = true;
    };
  };
}
