{
  user,
  pkgs,
  ...
}:
{
  home-manager.users.${user} = {
    programs.nushell = {
      settings.keybindings = [
        {
          name = "skim_file_finder";
          modifier = "control";
          keycode = "char_t";
          mode = [
            "emacs"
            "vi_normal"
            "vi_insert"
          ];
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
          @example "watch the root filesystem" {fswatch /}
          @example "watch the root filesystem while excluding /tmp" {fswatch / --exclude ^/tmp}
          def --wrapped fswatch [dir, ...rest] {
            (
              run0 fsnotifywait ($dir | path expand)
              --filesystem
              --monitor
              --quiet
              --event create,delete,modify,move
              --format "%e\t%w%f"
              ...$rest
            )
          }
        '';
    };
  };

  environment.systemPackages = [
    # system information
    pkgs.fastfetch

    # shell utils
    pkgs.wget
    pkgs.p7zip
    pkgs.skim
    pkgs.ripgrep
    pkgs.inotify-tools

    # network tools
    pkgs.dnsutils
    pkgs.inetutils
    pkgs.iw
    pkgs.speedtest-cli
  ];
}
