# based on https://github.com/NixOS/nixpkgs/commit/4bd737554e672ee3e357a1ed0d17ff3a1203fda0
{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  unstableGitUpdater,
  pytestCheckHook,
  fonttools,
  poetry-core,
  configparser,
  biplist,
}:
buildPythonPackage {
  pname = "opentype-feature-freezer";
  version = "v1.32.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "twardoch";
    repo = "fonttools-opentype-feature-freezer";
    rev = "0eb5b0e613bfaae5c203248c720707b100b88264";
    hash = "sha256-HVM8LRU2fMwvksEUfKUbo79eEvpa3HsC7CQiyXzOzXQ=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail poetry.masonry.api poetry.core.masonry.api \
      --replace-fail "poetry>=" "poetry-core>="
  '';

  build-system = [
    poetry-core
    configparser
  ];

  dependencies = [fonttools];

  nativeCheckInputs = [
    pytestCheckHook
    biplist
  ];

  disabledTestPaths = [
    # Wants to check path outside of nix store
    "src/opentype_feature_freezer/cli.py"
    # NameError: name 'defines' is not defined
    "app/dmgbuild_settings.py"
    # Missing module
    "app/OTFeatureFreezer.py"
    # AttributeError: 'types.SimpleNamespace' object has no attribute 'suffix'
    "tests/test_rename.py"
  ];

  passthru.updateScript = unstableGitUpdater {};

  meta = {
    description = "Permanently \"apply\" OpenType features to fonts, by remapping their Unicode assignments";
    homepage = "https://github.com/twardoch/fonttools-opentype-feature-freezer";
    license = lib.licenses.asl20;
    mainProgram = "pyftfeatfreeze";
    maintainers = with lib.maintainers; [jopejoe1];
  };
}
