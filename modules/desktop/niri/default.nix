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
    ./screen-recorder.nix
    ./desktop-shell.nix
    ./launcher.nix
    ./lockscreen.nix
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

  # programs.xwayland.enable = true;

  fonts.enableDefaultPackages = false;

  environment.systemPackages = with pkgs; [
    # needed by helix for clipboard paste
    wl-clipboard

    # audio config
    pavucontrol
    crosspipe
  ];
}
