{
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  python3,
  abseil-cpp,
  zlib,
  eigen,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "lc0";
  version = "git-d8ce482";

  src = fetchFromGitHub {
    owner = "LeelaChessZero";
    repo = "lc0";
    rev = "d8ce48258c39d331c119f8c8729374ceb3df8409";
    hash = "sha256-bVcjO6T4CpLpGm7LnRoW5hhojgcJOe1d8pl3sKG6Gzc=";
    fetchSubmodules = true;
  };

  postPatch = ''
    patchShebangs .
  '';

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    python3
  ];

  buildInputs = [
    abseil-cpp
    zlib

    # BLAS backend
    eigen
  ];

  mesonFlags = [
    # disable tests
    "-Dgtest=false"

    # disable metal backend
    "-Dmetal=disabled"
  ];

  enableParallelBuilding = true;

  meta.mainProgram = "lc0";
})
