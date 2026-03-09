{user, ...}: {
  services.openssh = {
    enable = true;
    ports = [51423];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [user];
    };
  };
}
