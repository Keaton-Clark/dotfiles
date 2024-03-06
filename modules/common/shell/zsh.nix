{ config, pkgs, lib, ... }: {
  users.users.${config.user}.shell = pkgs.zsh;
  programs.zsh.enable = true;
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [ direnv ];
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "duellj";
      };
      envExtra = ''
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'
        ZSH_AUTOSUGGEST_STRATEGY=(completion history)
        eval "$(direnv hook zsh)"
      '';
    };
  };
}
