{pkgs, ...}: {
  services.resolved = {
    enable = true;

    settings = {
      Resolve = {
        # for better security
        LLMNR = "false";
        FallbackDNS = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };
    };
  };

  networking.networkmanager.dns = "systemd-resolved";

  environment.systemPackages = with pkgs; [
    # network tools
    dnsutils
    inetutils
    iw
    speedtest-cli
  ];
}
