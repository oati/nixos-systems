{
  lib,
  stdenv,
  fetchFromGitHub,
  electron,
  makeWrapper,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "nibbler";
  version = "2.5.8";

  src = fetchFromGitHub {
    owner = "rooklift";
    repo = "nibbler";
    tag = "v${finalAttrs.version}";
    sha256 = "sha256-wB4UjgPg7Y1jJPC6Wl10atZaVplnDL/hZyfEiq11/ck=";
  };

  dontBuild = true;

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    mkdir -p $out/share $out/bin
    cp -r files/src $out/share/nibbler

    install -Dm644 files/res/nibbler.png -t $out/share/icons/hicolor/512x512/apps
    install -Dm644 files/res/nibbler.svg -t $out/share/icons/hicolor/scalable/apps
    install -Dm644 files/res/linux/nibbler.desktop -t $out/share/applications

    makeWrapper '${lib.getExe electron}' "$out/bin/nibbler" \
      --add-flags "$out/share/nibbler"
  '';

  meta.mainProgram = "nibbler";
})
