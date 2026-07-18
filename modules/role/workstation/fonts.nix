{ pkgs, ... }:
{
  fonts = {
    # defaulted to true by many desktop environments
    # enabling this breaks default font aliases for electron
    # since Liberation fonts capture hardcoded Arial / Times New Roman defaults
    # through 30-metric-aliases.conf
    enableDefaultPackages = false;

    # X11 fonts
    fontDir.enable = true;

    packages = [
      pkgs.monaspace
      pkgs.lexend
      pkgs.nerd-fonts.symbols-only
      pkgs.noto-fonts-color-emoji
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [
          "Monaspace Neon Frozen"
          "Symbols Nerd Font Mono"
        ];
        sansSerif = [ "Lexend" ];
        serif = [ "Lexend" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  stylix.fonts = {
    sizes = {
      # default 12
      applications = 12;
      desktop = 12;
      # terminal font follows applications
    };

    serif.name = "serif";
    sansSerif.name = "sans-serif";
    monospace.name = "monospace";
    emoji.name = "emoji";
  };
}
