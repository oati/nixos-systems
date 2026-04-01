{user, ...}: {
  home-manager.users.${user} = {
    programs.sioyek = {
      enable = true;

      # https://sioyek-documentation.readthedocs.io/en/latest/configuration.html
      config = {
        should_launch_new_window = "1";
        should_load_tutorial_when_no_other_file = "0";

        # generate search index
        super_fast_search = "1";
        prerender_page_count = "8";

        custom_background_color = "0.0 0.0 0.0";
        custom_text_color = "1.0 1.0 1.0";

        startup_commands = [
          "toggle_custom_color"
          "toggle_visual_scroll"
        ];
      };
    };
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".local/share/sioyek"
  ];
}
