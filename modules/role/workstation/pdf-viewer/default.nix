{
  user,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./keybinds.nix
  ];

  home-manager.users.${user} =
    { config, ... }:
    {
      programs.sioyek = {
        enable = true;

        package = pkgs.sioyek.overrideAttrs (prevAttrs: {
          pname = "sioyek-custom";

          # remove when sioyek > 2.0.0-unstable-2026-08-05
          version = "2.0.0-unstable-2026-08-14";
          src = prevAttrs.src.override {
            rev = "459774b7987e4b9364a7129aba63883219caec25";
            hash = "sha256-8OpFnIgu4any6rzMG2Zd3y3aNrgdyUWLj/aSR5RHIhU=";
          };

          postInstall = prevAttrs.postInstall + ''
            # no default keybinds
            rm $out/etc/keys.config
            touch $out/etc/keys.config

            # make desktop entry open a new window
            sed -i 's/^Exec=sioyek/& --new-window/' $out/share/applications/sioyek.desktop
          '';
        });

        # https://sioyek-documentation.readthedocs.io/en/latest/configuration.html
        config = {
          should_launch_new_window = "1";
          should_load_tutorial_when_no_other_file = "0";
          show_command_hints = "1";

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

          search_url_g = "https://google.com/search?hl=en&pws=0&udm=14&q=";
          search_url_w = "https://en.wikipedia.org/wiki/Special:Search/";
          search_url_d = "https://en.wiktionary.org/wiki/Special:Search/";
          search_url_s = "https://scholar.google.com/scholar?q=";

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
