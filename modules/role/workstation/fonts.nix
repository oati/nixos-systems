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
    ];

    fontconfig = {
      defaultFonts = {
        monospace = ["Monaspace Neon Frozen" "Symbols Nerd Font Mono"];
        sansSerif = ["Lexend"];
        serif = ["Lexend"];
      };
    };
  };
}
