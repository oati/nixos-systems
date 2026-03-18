{
  flakes,
  user,
  lib,
  pkgs,
  ...
}: {
  imports = [
    flakes.niri-flake.nixosModules.niri
    ../common/gtk.nix
    ./niri.nix
    ./keybinds.nix
    ./launcher.nix
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
    # audio config
    pavucontrol
    crosspipe
  ];
}
