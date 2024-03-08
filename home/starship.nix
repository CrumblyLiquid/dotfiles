{ globals, ... }:
{
  home-manager.users."${globals.user}" = {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        add_newline = true;
        format = " $directory$git_branch $git_status\n $sudo$character";
        right_format = "$jobs$cmd_duration$battery ";

        sudo = {
          symbol = "󰀗 ";
          format = "[$symbol]($style) ";
          style = "bold red";
          disabled = false;
        };

        jobs = {
          number_threshold = 1;
          format = "[$number $symbol]($style)  ";
        };

        battery.display = [
          {
            threshold = 15;
            style = "bold red";
          }

          {
            threshold = 30;
            style = "bold yellow";
          }
        ];

        # Prompt symbols
        character = {
          success_symbol = "[❯](green)";
          error_symbol = "[❯](red)";
          vicmd_symbol = "[](green)";
        };

        directory = {
          truncation_length = 5;
          truncate_to_repo = true;
        };

        git_branch = {
          format = "[$symbol$branch]($style)";
        };

        git_status = {
          format = "[\\[$all_status$ahead_behind\\]](red)";
          conflicted = "=";
          ahead = "⇡\${count}";
          behind = "⇣\${count}";
          diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
          up_to_date = "";
          untracked = "?\${count}";
          stashed = "";
          modified = "!\${count}";
          staged = "+\${count}";
          renamed = "»\${count}";
          deleted = "\${count}";
        };
        cmd_duration = {
          min_time = 1;
          format = "[神]($style)$duration";
        };

        username = {
          show_always = true;
          format = "$user";
        };

        hostname = {
          ssh_only = false;
          format = "$ssh_symbol$hostname";
        };
      };
    };
  };
}

