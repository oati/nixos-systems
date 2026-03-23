{
  user,
  pkgs,
  ...
}: {
  home-manager.users.${user} = {
    programs.librewolf = let
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        tab-session-manager
        multi-account-containers
        cookie-autodelete
        form-history-control
      ];

      private-extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        passff
        surfingkeys
        dark-background-light-text
        i-dont-care-about-cookies
        clearurls
        bypass-paywalls-clean
        sponsorblock
      ];

      nativeMessagingHosts = [pkgs.passff-host];

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
