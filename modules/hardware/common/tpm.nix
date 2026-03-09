{
  user,
  config,
  ...
}: {
  security.tpm2.enable = true;

  users.users.${user}.extraGroups = [config.security.tpm2.tssGroup];
}
