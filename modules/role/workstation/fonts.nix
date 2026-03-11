{pkgs, ...}: {
  fonts = {
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
