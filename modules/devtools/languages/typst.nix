{user, ...}: {
  home-manager.users.${user} = {
    programs.helix = {
      languages = {
        language = [
          {
            name = "typst";
            auto-format = true;
          }
        ];
      };
    };
  };
}
