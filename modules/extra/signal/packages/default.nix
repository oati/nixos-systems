{ ... }:
{
  nixpkgs.overlays = [
    # replace signal's Inter font with Lexend
    (
      final: prev:
      let
        lexend = "${final.lexend}/share/fonts/truetype/lexend/lexend";
      in
      {
        signal-desktop = prev.signal-desktop.overrideAttrs (prevAttrs: {
          nativeBuildInputs = prevAttrs.nativeBuildInputs ++ [ final.woff2 ];

          postPatch = prevAttrs.postPatch + ''
            # swap the upright faces for lexend
            pushd fonts/inter-*
            for weight in Regular Medium SemiBold Bold; do
              cp ${lexend}/Lexend-$weight.ttf Inter-$weight.ttf
              woff2_compress Inter-$weight.ttf
              rm Inter-$weight.ttf
            done
            popd

            # lexend has no italics, so drop the italic faces and
            # let chromium synthesise obliques from the upright ones
            sed -zi 's|@font-face *{[^@]*Italic\.woff2[^@]*}\n||g' stylesheets/_fontfaces.scss

            # and stop preloading the fonts they used
            sed -zi 's| *<link[^<]*Italic\.woff2[^<]*/\?>\n||g' background.html

            # sed says nothing when it matches nothing, so fail on a surviving reference
            if grep -q 'Italic\.woff2' stylesheets/_fontfaces.scss background.html; then
              die "inter italics survived"
            fi
          '';
        });
      }
    )
  ];
}
