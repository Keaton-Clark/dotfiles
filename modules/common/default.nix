{ config, lib, pkgs, ... }: {

  imports = [
    ./shell
    ./home-script.nix
  ];

  options = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "Primary user of the system";
    };
    fullName = lib.mkOption {
      type = lib.types.str;
      description = "Full name";
    };
    email = lib.mkOption {
      type = lib.types.str;
      description = "Email to use for git and such";
    };
    timeZone = lib.mkOption {
      type = lib.types.str;
      description = "System time zone";
    };
    gui.enable = lib.mkEnableOption {
      default = false;
      description = "Enable Graphics";
    };
  };

  config = let stateVersion = "23.11";
  in {
    time.timeZone = config.timeZone;
    # Default packages for all systems
    environment.systemPackages = with pkgs; [
      git
      wget
      vim
      htop-vim
      tmux
      bat
    ];

    # Use System level packages
    home-manager.useGlobalPkgs = true;

    virtualisation.docker.enable = true;
    
    # Install packages to /etc/profiles
    home-manager.useUserPackages = true;
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "google-chrome"
      "discord"
    ];

    home-manager.users.${config.user}.home.stateVersion = stateVersion;
    home-manager.users.root.home.stateVersion = stateVersion;
  };
}
