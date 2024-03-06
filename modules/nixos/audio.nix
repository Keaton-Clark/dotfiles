{ config, pkgs, lib, ... }: {
  config = {
    sound.enable = true;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        mpc-cli
        ncmpcpp
        ytmdl
      ];
      services.mpd = {
        enable = true;
        network = {
          startWhenNeeded = true;
          listenAddress = "any";
        };
        extraConfig = ''
          audio_output {
            type "alsa"
            name "Alsa"
            mixer_type "hardware"
            mixer_device "default"
          }
        '';
      };
    };
  };
}
