{
  user,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/gtk.nix
    ../common/qt.nix
    ./config.nix
    ./appearance.nix
    ./behavior.nix
    ./input-devices.nix
    ./keybinds.nix
    ./idle-lockscreen.nix
    ./desktop-shell.nix
    ./launcher.nix
    ./screen-recorder.nix
  ];

  niri-flake.cache.enable = false;

  services.displayManager = {
    gdm = {
      enable = true;
      # banner = "";
    };

    defaultSession = "niri";

    autoLogin = {
      enable = true;
      inherit user;
    };
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # conflicts with ssh-tpm-agent
  services.gnome.gnome-keyring.enable = lib.mkForce false;

  programs.xwayland.enable = true;

  home-manager.users.${user} = {
    home.packages = [
      pkgs.xwayland-satellite

      # needed by helix for clipboard paste
      pkgs.wl-clipboard

      # system resources monitor
      pkgs.resources

      # audio config
      pkgs.pavucontrol
      pkgs.crosspipe
    ];
  };
}
