{
  lib,
  pkgs,
  ...
}: {
  fonts = {
    # defaulted to true by many desktop environments
    enableDefaultPackages = false;

    # X11 fonts
    fontDir.enable = true;

    packages = let
      features = [
        # texture healing
        "calt"
        # consecutive symbols
        "liga"
        # stylistic sets
        # removed ss05 and ss08
        "ss01"
        "ss02"
        "ss03"
        "ss04"
        "ss06"
        "ss07"
        "ss09"
        "ss10"
      ];
      feature-freezer =
        lib.getExe'
        pkgs.python3Packages.opentype-feature-freezer
        "pyftfeatfreeze";
      monaspace-neon-frozen = pkgs.runCommand "monaspace-neon-frozen" {} ''
        mkdir -p $out/share/fonts/opentype

        ${feature-freezer} \
          --features "${lib.concatStringsSep "," features}" \
          "${pkgs.monaspace}/share/fonts/opentype/MonaspaceNeon-Regular.otf" \
          "$out/share/fonts/opentype/MonaspaceNeon-Regular.otf"
      '';
    in [
      monaspace-neon-frozen
      pkgs.lexend
      pkgs.nerd-fonts.symbols-only
    ];

    fontconfig = {
      defaultFonts = {
        monospace = ["Monaspace Neon" "Symbols Nerd Font Mono"];
        sansSerif = ["Lexend"];
        serif = ["Lexend"];
      };
    };
  };

  environment.systemPackages = [
    pkgs.python3Packages.opentype-feature-freezer
  ];
}
