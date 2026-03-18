{
  user,
  pkgs,
  ...
}: {
  home-manager.users.${user} = {
    programs.nix-index = {
      enable = true;
    };

    programs.nix-your-shell = {
      enable = true;
      nix-output-monitor.enable = true;

      # remove when nix-your-shell > 1.4.9
      package = pkgs.nix-your-shell.overrideAttrs (prev: {
        version = "git";
        src = pkgs.fetchFromGitHub {
          owner = "oati";
          repo = "nix-your-shell";
          rev = "f88fe1d00cfeb875d5452de5bf670ded63a2da1f";
          hash = "sha256-YBnfByywQY/oR6GahGnao1TIWLHxTZAsnMAuh8RmCw0=";
        };
      });
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
