{
  user,
  pkgs,
  ...
}: {
  imports = [
    ./packages
  ];

  home-manager.users.${user} = {
    home.packages = [
      pkgs.katago
      pkgs.sabaki
    ];
  };
}
