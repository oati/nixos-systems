{
  user,
  pkgs,
  ...
}: {
  home-manager.users.${user} = {
    programs.password-store = {
      enable = true;

      package =
        (pkgs.pass.override {
          x11Support = false;
          waylandSupport = true;
          dmenuSupport = false;
        }).withExtensions (p: [
          p.pass-genphrase
          p.pass-checkup
          p.pass-otp
        ]);
    };

    services.pass-secret-service.enable = true;

    home.packages = [pkgs.wofi-pass];
  };

  intransience.datastores.home.users.${user}.dirs = [
    {
      path = ".password-store";
      mode = "0700";
    }
  ];
}
