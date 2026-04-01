{user, ...}: {
  imports = [
    ./search-engines.nix
    ./extensions.nix
  ];

  home-manager.users.${user} = {config, ...}: {
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
        # open new tabs next to current tab
        "browser.tabs.insertAfterCurrent" = true;

        # always open links in the current tab
        "browser.link.open_newwindow" = 1;
        # open popups in new window
        "browser.link.open_newwindow.restriction" = 2;
        # open external links in new window
        "browser.link.open_newwindow.override.external" = 2;

        # use system fonts on webpages
        "browser.display.use_document_fonts" = 0;

        # only show bookmarks toolbar in new tab
        "browser.toolbars.bookmarks.visibility" = "newtab";

        # enable webgl
        # "webgl.disabled" = false;

        # middle mouse click to scroll
        "middlemouse.paste" = false;
        "general.autoScroll" = true;

        # disable autoplay
        "media.autoplay.blocking_policy" = 2;

        # graphics and audio
        "gfx.wayland.hdr" = true;
        "gfx.wayland.hdr.force-enabled" = true;
        "gfx.wayland.compositor" = true;
        "gfx.wayland.compositor.force-enabled" = true;

        "gfx.webrender.all" = true;
        "gfx.webrender.layer-compositor" = true;
        "gfx.webrender.precache-shaders" = true;

        "layers.gpu-process.enabled" = true;
        "layers.gpu-process.force-enabled" = true;

        "media.gpu-process-decoder.enabled" = true;
        "media.gpu-process-encoder.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.hardware-video-encoding.force-enabled" = true;
        "media.mkv.enabled" = true;
        "media.hls.enabled" = true;

        "media.webrtc.camera.allow-pipewire" = true;
        "media.webrtc.hw.h264.enabled" = true;

        "widget.wayland.fractional-scale.enabled" = true;
        "widget.gtk.global-menu.wayland.enabled" = true;

        # clear history, form data, cache, and site settings on shutdown
        "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
        "privacy.clearOnShutdown_v2.formdata" = true;
        "privacy.clearOnShutdown_v2.cache" = true;
        "privacy.clearOnShutdown_v2.siteSettings" = true;

        # allow cookies and site data on shutdown (managed by cookie autodelete)
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;

        # disable resume from crash
        "browser.sessionstore.resume_from_crash" = false;
      };
    };

    xdg.mimeApps.defaultApplicationPackages = [
      config.programs.librewolf.package
    ];
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".librewolf"
  ];
}
