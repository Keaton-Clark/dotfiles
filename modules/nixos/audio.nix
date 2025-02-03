{ config, pkgs, lib, ... }: {
  config = {
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      audio.enable = true;
      wireplumber = {
        enable = true;
        configPackages = [
          (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
            bluez_monitor.properties = {
              ["bluez5.enable-sbc-xq"] = true,
              ["bluez5.enable-msbc"] = true,
              ["bluez5.enable-hw-volume"] = true,
              ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
            }
          '')
        ];
      };
    };
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        ytmdl
        playerctl
      ];
      services.mpd = {
        enable = true;
        network = {
          startWhenNeeded = true;
        };
        extraConfig = ''
          audio_output {
            type "pulse"
            name "Pulse"
            mixer_type "hardware"
          }
        '';
      };
      services.mpdris2 = {
        enable = true;
        notifications = true;
      };
      services.playerctld.enable = true;
    };
  };
}
