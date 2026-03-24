{lib, ...}: {
  services.udev = {
    extraRules = let
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
  };
}
