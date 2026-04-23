{
  fetchCrate,
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "nu-lsp";
  version = "0.111.0";

  src = fetchCrate {
    inherit (finalAttrs) pname version;
    hash = "sha256-33TeJt1mGFb2O/blNl9N3EGc5NtBDKZ8krSwWIQIC18=";
  };

  cargoHash = "sha256-ofrweNpxc5ZaNN/bzYDeSb3Q/SE32675O+I5OasLBFI=";

  doCheck = false;

  meta.mainProgram = "nu-lsp";
})
