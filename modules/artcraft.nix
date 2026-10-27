# Craft-приложения (photocraft, filmcraft) из стороннего репозитория nix-craftapps.
{ pkgs, ... }:

let
  src = builtins.fetchTarball {
    url = "https://github.com/olafkfreund/nix-craftapps/archive/edf59f8aeb007d869dd2464dd6bb52db3b0452ca.tar.gz";
    sha256 = "1gyb9p6lf7r2d4bgdy0a6f2sv7hwisrig907mdnl6w78gl6ywfkl";
  };
  craftapps = import src { inherit pkgs; };
in
{
  environment.systemPackages = [
    craftapps.photocraft
    craftapps.wordcraft
    craftapps.gridcraft
    craftapps.pdfcraft
  ];
  hardware.graphics.enable = true;
  fonts.fontDir.enable = true;
  systemd.tmpfiles.rules = [
    "L+ /usr/share/fonts - - - - /run/current-system/sw/share/X11/fonts"
  ];
}
