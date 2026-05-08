{
  user,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./jujutsu.nix
    ./jjui.nix
  ];

  home-manager.users.${user} = {
    home.packages = with pkgs; [
      gh
    ];
  };
}
