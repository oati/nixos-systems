{user, ...}: {
  imports = [
    ./search-engines.nix
    ./extensions.nix
  ];

  home-manager.users.${user} = {
    programs.librewolf = {
      enable = true;

      # https://mozilla.github.io/policy-templates/
      policies = {
        # hide hints
        SkipOnboarding = true;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
      };

      # https://librewolf.net/docs/settings/
      settings = {
        # always open links in the current tab
        "browser.link.open_newwindow" = 1;

        # use system fonts on webpages
        "browser.display.use_document_fonts" = 0;

        # only show bookmarks toolbar in new tab
        "browser.toolbars.bookmarks.visibility" = "newtab";

        # disable resume from crash
        "browser.sessionstore.resume_from_crash" = false;

        # enable webgl
        # "webgl.disabled" = false;

        # middle mouse click to scroll
        "middlemouse.paste" = false;
        "general.autoScroll" = true;

        # disable autoplay
        "media.autoplay.blocking_policy" = 2;
      };
    };
  };

  intransience.datastores.home.users.${user}.dirs = [
    # ".librewolf"
  ];
}
