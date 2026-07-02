{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  makeBinaryWrapper,
  electron,
  makeDesktopItem,
  copyDesktopItems,
}:
buildNpmPackage (finalAttrs: {
  pname = "sabaki";
  version = "git-848745b";

  src = fetchFromGitHub {
    owner = "SabakiHQ";
    repo = "Sabaki";
    rev = "848745bdcc85183eb379fa57f0cd5499cdf90af7";
    hash = "sha256-3GY4S1pgbmKWkgr9nLhkFPRGo1JxXPfn6G6vD3vq8tQ=";
  };

  __structuredAttrs = true;

  npmDepsHash = "sha256-5QIhV2XbnSEXQBG566pxanDymQ3Xr3PxarhVxDXIYHk=";

  nativeBuildInputs = [
    makeBinaryWrapper
    copyDesktopItems
  ];

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
      categories = [
        "Game"
        "BoardGame"
      ];
      mimeTypes = [ "application/x-go-sgf" ];
    })
  ];

  meta.mainProgram = "sabaki";
})
