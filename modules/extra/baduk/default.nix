{
  user,
  pkgs,
  ...
}:
{
  imports = [
    ./packages
  ];

  home-manager.users.${user} =
    { lib, ... }:
    {
      home.packages = [
        pkgs.katago
        pkgs.sabaki
      ];

      home.activation = {
        setSabakiSettings =
          let
            settings = { };
          in
          lib.hm.dag.entryAfter [ "writeBoundary" ]
            # sh
            ''
              run mkdir -p $VERBOSE_ARG ~/.config/Sabaki
              run cp $VERBOSE_ARG \
                --remove-destination \
                --no-preserve=mode \
                ${pkgs.writers.writeJSON "sabaki-settings" settings} \
                ~/.config/Sabaki/settings.json
            '';
      };
    };
}
