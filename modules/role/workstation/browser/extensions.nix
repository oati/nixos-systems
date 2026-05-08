{
  user,
  pkgs,
  ...
}: {
  home-manager.users.${user} = {
    programs.librewolf = let
      p = pkgs.nur.repos.rycee.firefox-addons;

      extensions = [
        p.tab-session-manager
        p.multi-account-containers
        p.cookie-autodelete
        p.form-history-control
      ];

      private-extensions = [
        p.passff
        p.surfingkeys
        p.dark-background-light-text
        p.i-dont-care-about-cookies
        p.clearurls
        p.bypass-paywalls-clean
        p.ff2mpv
        p.sponsorblock
      ];

      nativeMessagingHosts = [
        pkgs.passff-host
        pkgs.ff2mpv-rust
      ];

      getXpi = package: "file://${package}/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/${package.addonId}.xpi";
    in {
      inherit nativeMessagingHosts;

      policies = {
        # https://mozilla.github.io/policy-templates/#extensionsettings
        ExtensionSettings =
          {
            "*" = {
              installation_mode = "blocked";
              default_area = "menupanel";
            };
          }
          # install extensions
          // builtins.listToAttrs (map (package: {
              name = package.addonId;
              value = {
                install_url = getXpi package;
                installation_mode = "normal_installed";
              };
            })
            extensions)
          // builtins.listToAttrs (map (package: {
              name = package.addonId;
              value = {
                install_url = getXpi package;
                installation_mode = "normal_installed";
                private_browsing = true;
              };
            })
            private-extensions);
      };
    };
  };
}
