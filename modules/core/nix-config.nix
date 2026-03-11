{
  flakes,
  user,
  ...
}:
{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "cgroups"
        "auto-allocate-uids"
      ];
      use-cgroups = true;
      auto-allocate-uids = true;
      use-xdg-base-directories = true;
      preallocate-contents = true;
      sync-before-registering = true;
      # determinate nix
      # lazy-trees = true;
      # eval-cores = 0;

      log-lines = 50;

      auto-optimise-store = true;
      keep-outputs = true;
      # show-trace = true;
      trusted-users = [ "@wheel" ];

      commit-lock-file-summary = "flake.lock: update";
    };

    # extraOptions = "";

    channel.enable = false;

    registry = {
      nixpkgs.flake = flakes.nixpkgs;

      templates.to = {
        type = "github";
        owner = "oati";
        repo = "flake-templates";
      };
    };
  };

  intransience.datastores.home.users.${user}.files = [
    ".local/share/nix/trusted-settings.json"
  ];

  # workaround unti intransience adds support
  systemd.tmpfiles.settings."12-intransience-binds-home"."/safe/home/home/${user}/.local/share/nix/trusted-settings.json".f.argument =
    "{}";
}
