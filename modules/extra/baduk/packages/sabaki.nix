{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  makeWrapper,
  electron,
  makeDesktopItem,
  copyDesktopItems,
}:
buildNpmPackage (finalAttrs: {
  pname = "sabaki";
  version = "git-950c5d9";

  src = fetchFromGitHub {
    owner = "SabakiHQ";
    repo = "Sabaki";
    rev = "950c5d9f6b4eeb0d9090aff6fe91c42b0221632e";
    hash = "sha256-3VzA/YmGSheBvY43tyNByqC0KPESEQd726TIt4O2Y60=";
  };

  __structuredAttrs = true;

  npmDepsHash = "sha256-RPFhBe7APSYK58pRcTraep5oLYgT9hWP742wFsx1zwA=";

  nativeBuildInputs = [makeWrapper copyDesktopItems];

  env = {
    ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
  };

  buildPhase = ''
    runHook preBuild

    npm run bundle

    ./node_modules/.bin/electron-builder \
      --dir \
      -c.electronDist='${electron.dist}' \
      -c.electronVersion='${electron.version}'

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/sabaki
    cp dist/*-unpacked/resources/app.asar $out/share/sabaki
    install -Dm644 logo.png $out/share/icons/hicolor/scalable/apps/sabaki.png

    makeWrapper '${lib.getExe electron}' "$out/bin/sabaki" \
      --add-flags "$out/share/sabaki/app.asar" \
      --inherit-argv0

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "sabaki";
      desktopName = "Sabaki";
      comment = "Go/Baduk/Weiqi board and SGF editor";
      exec = "sabaki %U";
      icon = "sabaki";
      categories = ["Game" "BoardGame"];
      mimeTypes = ["application/x-go-sgf"];
    })
  ];

  meta.mainProgram = "sabaki";
})
