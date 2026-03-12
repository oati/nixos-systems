{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = false;

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    override = {
      base00 = "000000";
    };

    fonts = {
      sizes = {
        # defaults
        applications = 12;
        desktop = 10;
        # terminal follows applications
      };

      serif.name = "serif";
      sansSerif.name = "sans-serif";
      monospace.name = "monospace";
      emoji.name = "emoji";
    };
  };
}
