{flakes, ...}: {
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
      # unsure about these
      keep-outputs = true;
      # show-trace = true;
      trusted-users = ["@wheel"];
    };

    # extraOptions = "";

    channel.enable = false;

    registry = {
      nixpkgs.flake = flakes.nixpkgs;
    };
  };
}
