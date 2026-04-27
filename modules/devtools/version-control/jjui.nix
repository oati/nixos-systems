{user, ...}: {
  home-manager.users.${user} = {
    programs.jjui = {
      enable = true;

      # https://idursun.github.io/jjui/customization/config-toml/
      settings = {
        # https://github.com/idursun/jjui/blob/main/internal/config/default/bindings.toml
        bindings = [
          # navigation
          {
            key = "shift+up";
            action = "revisions.jump_to_children";
            scope = "revisions";
            desc = "jump to children";
          }
          {
            key = "shift+down";
            action = "revisions.jump_to_parent";
            scope = "revisions";
            desc = "jump to parent";
          }

          # inline describe
          {
            key = "enter";
            action = "revisions.inline_describe.accept";
            scope = "revisions.inline_describe";
            desc = "accept";
          }
          {
            key = "alt+enter";
            action = "revisions.inline_describe.force_accept";
            scope = "revisions.inline_describe";
            desc = "force accept";
          }
          {
            key = "shift+enter";
            action = "revisions.inline_describe.new_line";
            scope = "revisions.inline_describe";
            desc = "new line";
          }
        ];
      };
    };

    stylix.targets.jjui.enable = true;
  };
}
