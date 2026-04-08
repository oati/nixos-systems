{
  user,
  lib,
  pkgs,
  ...
}: {
  # access to serial ports
  users.users.${user}.extraGroups = ["dialout"];

  # udev rules
  # see https://github.com/NixOS/nixpkgs/issues/308681
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "usb-udev-rules";
      destination = "/etc/udev/rules.d/70-usb.rules";
      text = let
        ids = [
          # raspberry pi
          # {vendor = "2e8a";}

          # adafruit bootloader
          # {vendor = "2fe3";}

          # nordic semiconductor
          # {vendor = "1915";}

          # atmega32u4
          {
            vendor = "03eb";
            product = "2ff4";
          }

          # quansheng uv-k1
          {
            vendor = "36b7";
            product = "ffff";
          }
        ];
      in
        lib.concatMapStringsSep "\n" (
          {
            vendor,
            product ? null,
            products ?
              if product != null
              then [product]
              else null,
          }:
            if products != null
            then
              lib.concatMapStringsSep "\n"
              (product:
                lib.concatStringsSep ", " [
                  ''SUBSYSTEMS=="usb"''
                  ''ATTRS{idVendor}=="${vendor}"''
                  ''ATTRS{idProduct}=="${product}"''
                  ''TAG+="uaccess"''
                ])
              products
            else
              lib.concatStringsSep ", " [
                ''SUBSYSTEMS=="usb"''
                ''ATTRS{idVendor}=="${vendor}"''
                ''TAG+="uaccess"''
              ]
        )
        ids;
    })
  ];
}
