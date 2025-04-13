{ pkgs, lib, config, ... }:

{
  options = {
    wofi = {
      enable = lib.mkEnableOption "Enables wofi";
    };
  };

  config = lib.mkIf config.wofi.enable {
    programs.wofi = {
      enable = true;
      settings = {
        show = "drun";
        matching = "fuzzy";
        no_actions = true;
        width = 550;
        height = 325;
        always_parse_args = true;
        show_all = true;
        print_command = true;
        layer = "overlay";
        insensitive = true;
        prompt = "Search...";
        allow_markup = true;
        allow_images = true;
      };
      style = ''
        window {
            margin: 0px;
            background-color: #faf4ed;
            border-radius: 0px;
            border: 2px solid #b4637a;
            color: #575279;
            font-family: 'CaskaydiaCove Nerd Font';
            font-size: 20px;
        }

        #input {
            margin: 5px;
            border-radius: 0px;
            border: none;
            color: #b4637a;
            background-color: #f2e9e1;
        }

        #inner-box {
            margin: 5px;
            border: none;
            background-color: #f2e9e1;
            color: #faf4ed;
            border-radius: 0px;
        }

        #outer-box {
            margin: 15px;
            border: none;
            background-color: #faf4ed;
        }

        #scroll {
            margin: 0px;
            border: none;
        }

        #text {
            margin: 5px;
            border: none;
            color: #575279;
        }

        #entry:selected {
            background-color: #b4637a;
            color: #faf4ed;
            border-radius: 0px;
            outline: none;
        }

        #entry:selected * {
            background-color: #b4637a;
            color: #faf4ed;
            border-radius: 0px;
            outline: none;
        }
      '';
    };
  };
}

