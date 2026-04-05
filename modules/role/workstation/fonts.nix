{pkgs, ...}: {
  fonts = {
    # defaulted to true by many desktop environments
    enableDefaultPackages = false;

    # X11 fonts
    fontDir.enable = true;

    packages = with pkgs; [
      monaspace
      lexend
      nerd-fonts.symbols-only
      noto-fonts-color-emoji
    ];

    fontconfig = {
      defaultFonts = {
        monospace = ["Monaspace Neon Frozen" "Symbols Nerd Font Mono"];
        sansSerif = ["Lexend"];
        serif = ["Lexend"];
        emoji = ["Noto Color Emoji"];
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
