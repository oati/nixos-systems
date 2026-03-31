{user, ...}: {
  home-manager.users.${user} = {
    programs.sioyek = {
      enable = true;

      config = {
        custom_background_color = "0.0 0.0 0.0";
        custom_text_color = "1.0 1.0 1.0";

        super_fast_search = "";
        prerender_page_count = "8";

        startup_commands = [
          "toggle_custom_color"
        ];
      };
    };
  };

  intransience.datastores.home.users.${user}.dirs = [
    ".local/share/sioyek"
  ];
}
