{ user, pkgs, ... }:
let
  package = pkgs.musescore;
in
{
  imports = [
    ./musesounds.nix
  ];

  home-manager.users.${user} =
    { lib, ... }:
    {
      home.packages = [ package ];

      home.activation = {
        setMusescoreSettings =
          let
            settings = {
              application = {
                checkForUpdate = false;
                hasCompletedFirstLaunchSetup = true;
                welcomeDialogShowOnStartup = false;
                # ensures that musescore does not turn the welcome dialog back on
                welcomeDialogLastShownVersion = "99.0.0";
              };

              project = {
                # don't prompt about saving to cloud
                lastUsedSaveLocationType = 1;
                shouldAskSaveLocationType = false;
              };

              ui = {
                "application\\followSystemTheme" = true;
                "canvas\\onlyInvertInDarkTheme" = true;
              };

              engraving = {
                scoreColorInversion = true;
              };
            };
          in
          lib.hm.dag.entryAfter [ "writeBoundary" ]
            # sh
            ''
              run mkdir -p $VERBOSE_ARG ~/.config/MuseScore
              run cp $VERBOSE_ARG \
                --remove-destination \
                --no-preserve=mode \
                ${(pkgs.formats.ini { }).generate "musescore-settings" settings} \
                ~/.config/MuseScore/MuseScore4.ini
            '';

      };
    };
}
