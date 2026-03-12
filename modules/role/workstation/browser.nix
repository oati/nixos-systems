{user, ...}: {
  home-manager.users.${user} = {
    programs.librewolf = {
      enable = true;

      # https://mozilla.github.io/policy-templates/
      policies = {};

      profiles = {};

      # https://librewolf.net/docs/settings/
      settings = {
        # open links in new window
        "browser.link.open_newwindow" = 2;

        # allow custom CSS
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # enable IPv6
        "network.dns.disableIPv6" = false;

        # enable webgl
        # "webgl.disabled" = false;

        # firefox sync
        # "identity.fxaccounts.enabled" = true;

        # google safe browsing
        "browser.safebrowsing.malware.enabled" = true;
        "browser.safebrowsing.phishing.enabled" = true;
        "browser.safebrowsing.blockedURIs.enabled" = true;
        "browser.safebrowsing.provider.google4.gethashURL" = "https://safebrowsing.googleapis.com/v4/fullHashes:find?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST";
        "browser.safebrowsing.provider.google4.updateURL" = "https://safebrowsing.googleapis.com/v4/threatListUpdates:fetch?$ct=application/x-protobuf&key=%GOOGLE_SAFEBROWSING_API_KEY%&$httpMethod=POST";
        "browser.safebrowsing.provider.google.gethashURL" = "https://safebrowsing.google.com/safebrowsing/gethash?client=SAFEBROWSING_ID&appver=%MAJOR_VERSION%&pver=2.2";
        "browser.safebrowsing.provider.google.updateURL" = "https://safebrowsing.google.com/safebrowsing/downloads?client=SAFEBROWSING_ID&appver=%MAJOR_VERSION%&pver=2.2&key=%GOOGLE_SAFEBROWSING_API_KEY%";

        # google safe browsing for downloads
        "browser.safebrowsing.downloads.enabled" = true;
      };
    };

    # stylix.targets.librewolf = {
    #   enable = true;
    #   colors.enable = false;
    #   profileNames = [];
    # };
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".librewolf"
  ];
}
