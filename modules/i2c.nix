# Включает автоматическую загрузку модуля i2c-dev при старте.
# Это позволит ddcutil работать с монитором компа, управлять его яркостью.
{ config, pkgs, ... }:

{
  hardware.i2c.enable = true;
  boot.kernelModules = [ "i2c-dev" ];
  users.users.hehs.extraGroups = [ "i2c" ];
}
