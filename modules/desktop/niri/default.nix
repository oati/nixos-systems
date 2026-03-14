{
  user,
  pkgs,
  ...
}: {
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
    useNautilus = true;
  };

  # conflicts with ssh-tpm-agent
  services.gnome.gnome-keyring.enable = false;

  # programs.xwayland.enable = true;

  environment.systemPackages = with pkgs; [
    # audio config
    pavucontrol
    crosspipe
  ];
}
