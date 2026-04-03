{
  user,
  pkgs,
  ...
}: {
  home-manager.users.${user} = {
    programs.nushell = {
      settings.keybindings = [
        {
          name = "skim_file_finder";
          modifier = "control";
          keycode = "char_t";
          mode = ["emacs" "vi_normal" "vi_insert"];
          event = {
            send = "executehostcommand";
            cmd =
              # nu
              ''
                commandline edit --insert (ls **/* | where type == file | get name | str join (char newline) | sk)
              '';
          };
        }
      ];

      extraConfig =
        # nu
        ''
          # run nushell command with elevated privileges
          def --wrapped nu0 [...args] {
            run0 nu -c ($args | str join " ")
          }

          # watch the filesystem of a directory for changes
          def fswatch [dir] {
            (
              run0 fsnotifywait ($dir | path expand)
              --filesystem
              --monitor
              --quiet
              --event create,delete,modify,move
              --format "%e\t%w%f"
            )
          }
        '';
    };
  };

  environment.systemPackages = with pkgs; [
    # system information
    fastfetch

    # shell utils
    wget
    skim
    ripgrep
    inotify-tools

    # network tools
    dnsutils
    inetutils
    iw
    speedtest-cli
  ];
}
