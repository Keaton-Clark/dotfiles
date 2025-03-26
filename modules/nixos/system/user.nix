{ config, lib, pkgs, ... }: {

  options = {

    passwordHash = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "Password created with mkpasswd -m sha-512";
      default = null;
      # Test it by running: mkpasswd -m sha-512 --salt "PZYiMGmJIIHAepTM"
    };

  };

  config = {

    # Allows us to declaritively set password
    users.mutableUsers = false;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${config.user} = {

      # Create a home directory for human user
      isNormalUser = true;

      # Automatically create a password to start
      hashedPassword = config.passwordHash;

      extraGroups = [
        "wheel" # Sudo privileges
        "dialout"
        "docker"
      ];

    };
    
    home-manager.users.${config.user} = {
      fonts.fontconfig.enable = true;
      home.homeDirectory = "/home/${config.user}";
      services.screen-locker = {
        enable = true;
        lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock";
      };
      xdg = let
        homeDirectory = config.home-manager.users.${config.user}.home.homeDirectory;
      in {
        # Allow Nix to manage the default applications list
        mimeApps.enable = true;
        # Set directories for application defaults
        userDirs = {
          enable = true;
          createDirectories = true;
          documents = "${homeDirectory}/documents";
          download = "${homeDirectory}/downloads";
          music = "${homeDirectory}/media/music";
          pictures = "${homeDirectory}/media/images";
          videos = "${homeDirectory}/media/videos";
          desktop = "${homeDirectory}/other/desktop";
          publicShare = "${homeDirectory}/other/public";
          templates = "${homeDirectory}/other/templates";
          extraConfig = { 
            XDG_DEV_DIR = "${homeDirectory}/dev"; 
          };
        };
      };
    };
  };

}
