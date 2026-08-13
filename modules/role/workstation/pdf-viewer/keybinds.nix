{ user, ... }:
{
  home-manager.users.${user} = {
    # https://github.com/ahrm/sioyek/blob/development/pdf_viewer/keys.config
    # https://sioyek-documentation.readthedocs.io/en/latest/commands.html
    programs.sioyek.bindings = {
      command = ":";
      new_window = "<C-n>";
      toggle_custom_color = "c";

      # highlight links
      toggle_highlight = "l";

      # table of contents
      goto_toc = "t";

      # selection
      keyboard_select = "s";
      copy = [
        "y"
        "<C-c>"
      ];

      # visual mark
      enter_visual_mark_mode = "v";
      focus_text = "V";
      move_visual_mark_up = "<up>";
      move_visual_mark_down = "<down>";

      # basic movement
      move_up = "<up>";
      move_down = "<down>";
      move_left = "<right>";
      move_right = "<left>";

      screen_up = "u";
      screen_down = "d";

      goto_top_of_page = "<home>";
      goto_bottom_of_page = "<end>";

      goto_left_smart = "<C-<left>>";
      goto_right_smart = "<C-<right>>";

      "goto_top_of_page;goto_right_smart" = "<C-d>";
      "goto_bottom_of_page;goto_left_smart" = "<C-u>";

      # navigation
      goto_beginning = "gg";
      goto_end = "ge";
      goto_page_with_page_number = "gn";
      goto_page_with_label = "gN";

      goto_selected_text = "gs";
      goto_overview = "go";
      goto_bookmark = "gb";
      goto_bookmark_g = "gB";
      goto_highlight = "gh";
      goto_highlight_g = "gH";
      goto_portal_list = "gP";

      keyboard_smart_jump = "gw";
      open_link = "gl";

      goto_portal = "gp";
      goto_definition = "gd";

      previous_page = "[p";
      next_page = "]p";

      prev_chapter = "[c";
      next_chapter = "]c";

      goto_prev_highlight = "[h";
      goto_next_highlight = "]h";

      goto_prev_highlight_of_type = "[H";
      goto_next_highlight_of_type = "]H";

      prev_state = "<A-<left>>";
      next_state = "<A-<right>>";

      # zoom and view
      zoom_in = "=";
      zoom_out = "-";

      fit_to_page_width = "zw";
      fit_to_page_width_smart = "zW";
      fit_to_page_height = "zh";
      fit_to_page_height_smart = "zH";

      rotate_clockwise = "r";
      rotate_counterclockwise = "R";

      # open document
      open_document = "f";
      open_prev_doc = "<tab>";
      open_document_embedded_from_current_path = "F";
      open_document_embedded = "<C-F>";

      # search
      external_search = "?";

      search = "/";
      chapter_search = "<C-/>";
      regex_search = "<A-/>";

      next_item = "n";
      previous_item = "N";

      # marks
      set_mark = "m";
      goto_mark = "'";

      # bookmarks
      add_bookmark = "b";
      delete_bookmark = "Db";

      # highlights
      add_highlight_with_current_type = "h";
      set_select_highlight_type = "<C-h>";
      add_highlight = "H";
      delete_highlight = "Dh";

      # portals
      portal = "pp";
      portal_to_overview = "po";
      portal_to_link = "pl";
      portal_to_definition = "pd";
      edit_portal = "pe";
      delete_portal = "Dp";

      # helper window
      toggle_one_window = "pw";

      # overview
      keyboard_overview = "Ow";
      overview_to_portal = "Op";
      overview_link = "Ol";
      overview_definition = "Od";

      # overview in new window
      "keyboard_overview;goto_overview;new_window;prev_state" = "ow";
      "overview_to_portal;goto_overview;new_window;prev_state" = "op";
      "overview_link;goto_overview;new_window;prev_state" = "ol";
      "overview_definition;goto_overview;new_window;prev_state" = "od";
    };
  };
}
