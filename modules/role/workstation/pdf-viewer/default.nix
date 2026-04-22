{
  user,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./keybinds.nix
  ];

  home-manager.users.${user} = {config, ...}: {
    programs.sioyek = {
      enable = true;

      package = pkgs.sioyek.overrideAttrs (old: {
        name = "sioyek-no-default-keys";
        postInstall =
          old.postInstall
          + ''
            rm $out/etc/keys.config
            touch $out/etc/keys.config
          '';
      });

      # https://sioyek-documentation.readthedocs.io/en/latest/configuration.html
      config = {
        should_launch_new_window = "1";
        should_load_tutorial_when_no_other_file = "0";

        # generate search index
        super_fast_search = "1";
        prerendered_page_count = "8";

        status_font = "monospace";
        tag_font_face = "monospace";
        keyboard_select_font_size = "16";

        epub_font_size = "9";
        epub_css = lib.concatMapStringsSep " " lib.trim (
          lib.splitString "\n"
          # css
          ''
            @font-face {
              font-family: Lexend;
              src: url('${pkgs.lexend}/share/fonts/truetype/lexend/lexend/Lexend-Regular.ttf');
            }

            * {
              font-family: Lexend;
            }
          ''
        );

        custom_background_color = "0.0 0.0 0.0";
        custom_text_color = "1.0 1.0 1.0";

        overview_size = "1.0 0.3";
        overview_offset = "0.0 -0.7";

        search_url_g = "https://google.com/search?hl=en&pws=0&udm=14&hl=en&q=";

        startup_commands = [
          "toggle_custom_color"
          "toggle_visual_scroll"
        ];
      };
    };

    xdg.mimeApps.defaultApplicationPackages = [
      config.programs.sioyek.package
    ];
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".local/share/sioyek"
  ];
}
