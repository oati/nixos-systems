# definitions of systems
rec {
  minimal-x86_64-iso = [
    ./modules/hardware/live-usb-x86_64

    ./modules/core
    ./modules/identity/iso-image
    ./modules/role/installer
    ./modules/role/workstation

    ./modules/desktop/niri
    ./modules/devtools
  ];

  erin-pc-small = [
    ./modules/hardware/framework-13-ryzen-ai-300
    ./modules/filesystems/tmpfs-zfs

    ./modules/hardware/peripherals/portable-monitor
    ./modules/hardware/peripherals/drawing-tablet

    ./modules/core
    ./modules/identity/erin-pc
    ./modules/role/workstation

    ./modules/desktop/niri
    ./modules/devtools

    ./modules/security/gnupg
    ./modules/security/password-store

    ./modules/extra/discord
    ./modules/extra/signal
  ];

  erin-pc =
    erin-pc-small
    ++ [
      ./modules/extra/anytype
      ./modules/extra/steam
      ./modules/extra/osu-lazer
      ./modules/extra/iloader
      ./modules/extra/chirp
      ./modules/extra/chess
      # ./modules/extra/vmware
    ];
}
