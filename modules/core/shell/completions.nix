{
  user,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.${user} = {
    programs.carapace =
      let
        settings = {
          # bridges
          CARAPACE_BRIDGES = "zsh,fish,jj";

          # allow unkown flags for completions
          CARAPACE_LENIENT = 1;
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
        enable = true;
        inherit package;
      };
  };
}
