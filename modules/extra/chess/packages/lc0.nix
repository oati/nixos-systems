{
  stdenv,
  fetchFromGitHub,
  symlinkJoin,
  meson,
  ninja,
  pkg-config,
  python3,
  abseil-cpp,
  zlib,
  eigen,
  onednn,
  ispc,
  onnxruntime,
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

    # see https://github.com/LeelaChessZero/lc0/issues/2414
    sed -i \
      's|CommandLine::BinaryDirectory()|std::string(std::getenv("HOME")) + "/.cache/lc0"|g' \
      ./src/neural/backends/onnx/network_onnx.cc
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
    onednn
    ispc

    # ONNX backend
    onnxruntime
  ];

  mesonFlags = [
    # disable tests
    "-Dgtest=false"

    # disable metal backend
    "-Dmetal=disabled"

    # BLAS backend
    "-Ddnnl=true"
    (let
      onednn-combined = symlinkJoin {
        name = "onednn-combined";
        paths = [
          onednn
          onednn.dev
        ];
      };
    in "-Ddnnl_dir=${onednn-combined}")

    # ONNX backend
    "-Donnx=true"
    "-Donnx_libdir=${onnxruntime}/lib"
    "-Donnx_include=${onnxruntime.dev}/include"
  ];

  enableParallelBuilding = true;

  meta.mainProgram = "lc0";
})
