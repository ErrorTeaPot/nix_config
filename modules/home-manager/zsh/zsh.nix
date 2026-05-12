{
  lib,
  config,
  ...
}:
{
  options = {
    zsh = {
      enable = lib.mkEnableOption "Enables zsh";
    };
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        path = "$XDG_CONFIG_HOME/zsh/zsh_history";
        ignoreAllDups = true;
      };
    };
  };
}
