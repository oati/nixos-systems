{
  user,
  pkgs,
  ...
}: {
  services.displayManager = {
    cosmic-greeter.enable = true;

    autoLogin = {
      enable = true;
      inherit user;
    };
  };

  services.desktopManager.cosmic.enable = true;

  environment.cosmic.excludePackages = [];

  services.system76-scheduler.enable = true;

  # conflicts with ssh-tpm-agent
  services.gnome.gnome-keyring.enable = false;

  environment.systemPackages = with pkgs; [
    # audio config
    pavucontrol
    crosspipe
  ];
}
