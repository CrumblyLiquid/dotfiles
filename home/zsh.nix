{ globals, ... }: {
  programs.zsh = {
    enable = true;

    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" "man" "tmux" ];
    };
  };

  home-manager.users."${globals.user}" = {
    programs.zsh = {
      enable = true;

      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      autocd = true;

      history.size = 10000;

      shellAliases = {
        nv = "nvim";
        dotfiles = "cd ~/.dots";
        dots = "dotfiles";
        sl = "sl -e";
        gpp = "g++";
        gppwp = "g++ -Wall -pedantic";
      };

      initExtra = ''
        # Go up certain amount of directories
        up () {
          if [ -z $1 ]; then
            cd ..
          elif [ $1 -gt 0 ]; then
            let count=1
            cdstr=".."
            while [ $count -lt $1 ]; do
              cdstr="$cdstr/.."
              let count=count+1
            done
            cd $cdstr
          else
            echo "Argument must be a positive integer."
          fi
        }

        run () {
          g++ -std=c++17 -Wall -pedantic -Wno-long-long -O2 -o "$1.bin" "$1.c";
          chmod u+x "./$1.bin";
          ./"$1.bin";
        }
      '';
    };
  };
}
