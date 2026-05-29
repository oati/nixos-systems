{ user, ... }:
{
  home-manager.users.${user} = {
    programs.cargo = {
      enable = true;
    };
  };

  # see https://doc.rust-lang.org/cargo/guide/cargo-home.html
  intransience.datastores.cache.users.${user}.dirs = [
    ".local/share/cargo/registry"
    ".local/share/cargo/git"
  ];
}
