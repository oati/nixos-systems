# definitions of systems
rec {
  minimal-iso = [
    ./modules/hardware/x86_64-iso

    ./modules/core
    ./modules/identity/iso
    ./modules/role/workstation

    ./modules/desktop/niri
    ./modules/devtools
  ];

  erin-pc-small = [
    ./modules/hardware/framework-13-ryzen-ai-300
    ./modules/filesystems/tmpfs-zfs

    ./modules/core
    ./modules/identity/erin-pc
    ./modules/role/workstation

    ./modules/hardware/peripherals/portable-monitor
    ./modules/hardware/peripherals/drawing-tablet

    ./modules/desktop/niri
    ./modules/devtools

    # ./modules/extra/browser
    ./modules/extra/discord
  ];

  erin-pc =
    erin-pc-small
    ++ [
      # ./modules/extra/anytype
      # ./modules/extra/vmware
      # ./modules/extra/games
    ];
}
