{
  user,
  pkgs,
  ...
}:
{
  stylix = {
    enable = true;
    autoEnable = false;

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    override = {
      scheme = "Rose Pine New Moon";
      base00 = "000000";
    };
  };

  home-manager.users.${user} = {
    programs.helix = {
      settings.theme = "rose_pine_new_moon";

      themes.rose_pine_new_moon = {
        inherits = "rose_pine_moon";
        palette.base = "#000000";
      };
    };
  };
}
