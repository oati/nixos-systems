{
  fetchCrate,
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "nu-lsp";
  version = "0.113.0";

  src = fetchCrate {
    inherit (finalAttrs) pname version;
    hash = "sha256-6muPnGsX9gM5vWJ2p55pSfI+nY3rji31Sgj/zG7QQU8=";
  };

  cargoHash = "sha256-/0Q8ZXTnSiGvj+Lj+RF/88eKJ9SfW9CE0NBPp+Ozi14";

  doCheck = false;

  meta.mainProgram = "nu-lsp";
})
