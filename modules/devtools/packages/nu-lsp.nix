{
  fetchCrate,
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "nu-lsp";
  version = "0.114.1";

  src = fetchCrate {
    inherit (finalAttrs) pname version;
    hash = "sha256-3aHcAFhT3AStSov5D4QcwRGUANNqjw8ZztM8EsEaOEU=";
  };

  __structuredAttrs = true;

  cargoHash = "sha256-zf4iSJ1wq7DGBo2+x1OaRBT0NWyjLSPT6l0RojigaDI=";

  doCheck = false;

  meta.mainProgram = "nu-lsp";
})
