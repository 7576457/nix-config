{ pkgs, lib, ... }:

let
  unstable = import <nixpkgs-unstable> { };

  base = with pkgs; [ curl wget just gh soteria fastfetch alacritty glib ntfs3g exfat ];
  wayland = with pkgs; [ wl-gammarelay-rs wl-clipboard ];
  python = with pkgs; [ python3 unstable.uv unstable.ruff unstable.ty ];
  editors = with pkgs; [ helix delta ];
  tui = with pkgs; [ bluetui joshuto ];
  gui = with pkgs; [ nautilus file-roller gnome-boxes qbittorrent adwaita-icon-theme rofi ];
  gaming = with pkgs; [ lutris wineWow64Packages.staging winetricks ];
  network = with pkgs; [ unstable.amnezia-vpn sing-box ];
  ocr = with pkgs; [ grim slurp imagemagick tesseract ];
  lsp = with pkgs; [
    nil
    nixfmt
    rust-analyzer
    typescript-language-server
    vscode-langservers-extracted
    yaml-language-server
    taplo
    kdlfmt
    marksman
    markdown-oxide
  ];

  craftapps = import (builtins.fetchGit {
    url = "https://github.com/olafkfreund/nix-craftapps";
  }) { inherit pkgs; };
  craftappsList = with craftapps; [ photocraft wordcraft gridcraft pdfcraft ];

in
{
  environment = {
    shellAliases = {
      meta = "fastfetch";
      rebuild = "sudo nixos-rebuild switch";
      edit = "sudo hx /etc/nixos/configuration.nix";
      btr = "cat /sys/class/power_supply/BAT0/capacity";
    };
    systemPackages = lib.concatLists [
      base
      wayland
      python
      editors
      tui
      gui
      gaming
      network
      lsp
      ocr
      craftappsList
    ];
  };
}

