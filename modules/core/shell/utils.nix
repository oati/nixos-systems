{
  user,
  pkgs,
  ...
}: {
  home-manager.users.${user} = {
    programs.nushell = {
      extraConfig =
        # nu
        ''
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
    ripgrep
    inotify-tools

    # network tools
    dnsutils
    inetutils
    iw
    speedtest-cli
  ];
}
