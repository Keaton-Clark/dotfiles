{ config, lib, pkgs, ... }: let
    home-script = pkgs.writeShellScriptBin "home-script" ''
      function screen_rotation() {
        monitor-sensor \
          | grep --line-buffered "Accelerometer orientation changed" \
          | grep --line-buffered -o ": .*" \
          | while read -r line; do
            line="''${line#??}"
            if [ "$line" = "normal" ]; then
              rotate=normal
              matrix="0 0 0 0 0 0 0 0 0"
            elif [ "$line" = "left-up" ]; then
              rotate=left
              matrix="0 -1 1 1 0 0 0 0 1"
            elif [ "$line" = "right-up" ]; then
              rotate=right
              matrix="0 1 0 -1 0 1 0 0 1"
            elif [ "$line" = "bottom-up" ]; then
              rotate=inverted
              matrix="-1 0 1 0 -1 1 0 0 1"
            else
              echo "Unknown rotation: $line"
              continue
            fi

            xrandr --output "eDP-1" --rotate "$rotate"
            if ! [ -z "$2" ]; then
              xinput set-prop "WACF2200:00 056A:525D Touchscreen" --type=float "Coordinate Transformation Matrix" $matrix
            fi
            i3-msg restart
          done
      }
      [ "$1" = "screen_rotation" ] && screen_rotation && exit

      #begin main
        name="Main Menu"
        add_exec 'Calculator' 'rofi -show calc'
        add_exec 'Applications' 'rofi -show drun'
        add_link 'Clipboard' 'clipboard'
        add_link 'Tmux' 'tmux'
        add_link 'Music' 'music'
        add_link 'System' 'system'
      #begin system
        add_link 'Audio' 'audio'
        add_exec 'System Monitor' 'rofi -show top -modi top'
        add_exec 'Bluetooth' '${pkgs.rofi-bluetooth}/bin/rofi-bluetooth'
        add_exec 'Systemd' '${pkgs.rofi-systemd}/bin/rofi-systemd'
        add_exec 'Power' 'rofi -show p -modi p:rofi-power-menu'
      #end system
      #end main


      #begin audio
        add_exec 'Output' '${pkgs.rofi-pulse-select}/bin/rofi-pulse-select sink'
        add_exec 'Input' '${pkgs.rofi-pulse-select}/bin/rofi-pulse-select source'
        add_item 'Volume-' 'audio' 'amixer set "Master" "10%-"'
        add_item 'Volume+' 'audio' 'amixer set "Master" "10%+"'
        add_item 'Mute' 'audio' 'amixer set "Master" "toggle"'
        add_link "Current Volume: $(awk -F'[][]' '/Left:/ { print $2 }' <(amixer sget Master))" 'audio'
      #end audio

      #begin music
        add_exec 'Turn Off' 'killall mpv'
        add_exec 'Lofi Girl' 'killall mpv; mpv "https://play.streamafrica.net/lofiradio"'
        add_exec 'Chillhop' 'killall mpv; mpv "http://stream.zeno.fm/fyn8eh3h5f8uv"'
        add_exec 'Box Lofi' 'killall mpv; mpv "http://stream.zeno.fm/f3wvbbqmdg8uv"'
        add_exec 'The Bootleg Boy' 'killall mpv; mpv "http://stream.zeno.fm/0r0xa792kwzuv"' 
        add_exec 'Radio Spinner' 'killall mpv; mpv "https://live.radiospinner.com/lofi-hip-hop-64"'
        add_exec 'SmoothChill' 'killall mpv; mpv "https://media-ssl.musicradio.com/SmoothChill"'
      #end music

      #begin clipboard
        IFS='
        '
        for item in $(cliphist list | cut -f 2); do
          add_exec $item "wl-copy $item"
        done
        IFS=' '
      #end clipboard
      
      #begin tmux
        IFS='
        '
        for item in $(tmux list-sessions | cut -d : -f 1); do
          add_exec $item "kitty -e tmux attach-session -t $item"
        done
        IFS=' '
      #end tmux
    '';

in {
  home-manager.users.${config.user}.home.packages = [ home-script ];
}
