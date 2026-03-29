{user, ...}: {
  home-manager.users.${user} = {
    programs.wofi = {
      enable = true;

      settings = {
        cache_file = "/dev/null";
        no_actions = true;
        insensitive = true;

        location = "center";
        # default 50K
        width = "50%";
        # default 40%
        height = "40%";

        allow_images = true;
        image_size = 20;
      };

      style =
        # css
        ''
          #img {
            margin-right: 8px;
          }
        '';
    };
  };
}
