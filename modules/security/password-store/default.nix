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
        }).withExtensions (exts:
          with exts; [
            pass-genphrase
            pass-checkup
            pass-otp
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
