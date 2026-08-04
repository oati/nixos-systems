{
  config,
  user,
  lib,
  pkgs,
  ...
}:
let
  manPages = pkgs.buildEnv {
    name = "man-pages";

    paths =
      config.environment.systemPackages
      ++
        lib.filter
          # filter out carapace to prevent infinite recursion
          (p: (p.name or null) != package.name)
          config.home-manager.users.${user}.home.packages;

    pathsToLink = [ "/share/man" ];
    extraOutputsToInstall = [ "man" ];
  };

  fishCompletions = pkgs.runCommand "fish-completions" { nativeBuildInputs = [ pkgs.fish ]; } ''
    export HOME=$TMPDIR
    export MANPATH=${manPages}/share/man

    fish -c fish_update_completions

    mkdir -p $out
    cp $HOME/.cache/fish/generated_completions/*.fish $out
    cp ${pkgs.fish.src}/share/completions/*.fish $out
  '';

  settings = {
    # bridges
    CARAPACE_BRIDGES = "zsh,fish";
    # location of fish completions
    fish_complete_path = fishCompletions;

    # allow unkown flags for completions
    CARAPACE_LENIENT = true;
    # case insensitive
    CARAPACE_MATCH = 1;
  };

  completers = [
    pkgs.zsh
    pkgs.fish
  ];

  package = pkgs.symlinkJoin {
    name = "carapace-wrapped";
    inherit (pkgs.carapace) version meta;
    paths = [ pkgs.carapace ];

    nativeBuildInputs = [ pkgs.makeBinaryWrapper ];

    postBuild = lib.concatStringsSep " " (
      [ "wrapProgram $out/bin/carapace" ]
      ++ (lib.mapAttrsToList (name: value: "--set ${name} '${toString value}'") settings)
      ++ [ "--prefix PATH : ${lib.makeBinPath completers}" ]
    );
  };
in
{
  home-manager.users.${user} = {
    programs.carapace = {
      enable = true;
      inherit package;
    };
  };
}
