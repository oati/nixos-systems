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
      # workaround to use strong bindings for default fonts
      # defaultFonts uses binding="same"
      # fontconfig >= 2.18 causes this to inherit weak bindings in some contexts
      # which ranks below the (incorrect) name-based generic-family guesses in 48-guessfamily.conf
      # see https://github.com/NixOS/nixpkgs/issues/541553
      defaultFonts = {
        monospace = [ ];
        sansSerif = [ ];
        serif = [ ];
        emoji = [ ];
      };

      aliases =
        let
          defaultFonts = {
            monospace = [
              "Monaspace Neon Frozen"
              "Symbols Nerd Font Mono"
            ];
            sans-serif = [ "Lexend" ];
            serif = [ "Lexend" ];
            emoji = [ "Noto Color Emoji" ];
          };
        in
        builtins.mapAttrs (name: value: {
          binding = "strong";
          prefer = value;
        }) defaultFonts;
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
