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
          rev = "e440d162568f7f25b1e3f52134a4abf8414de979";
          hash = "sha256-HlpREbS30KHwtPXZfr9FoJDFlDRxBUa7QySqOZrbSls=";
        };
      });
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
