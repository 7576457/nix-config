{ config, pkgs, ... }:

let
  kdl-lsp = pkgs.rustPlatform.buildRustPackage rec {
    pname = "kdl-lsp";
    version = "6.5.0";
    src = pkgs.fetchCrate {
      inherit pname version;
      hash = "sha256-YLoOmsQMvkzXhMLlK4e0P3nLmKxXWBXckyx0v/m3SqM=";
    };
    cargoHash = "sha256-iwc4DFsrgpVw3g1fPjFIROznVli/ooXJwKpZYwZmSOI=";
  };
in
{
  system.stateVersion = "26.05";
  imports = [ ./hardware-configuration.nix ./modules ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        unstable = import <unstable> { config = config.nixpkgs.config; };
      })
    ];
  };
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  boot = {
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      limine = {
        enable = true;
        efiInstallAsRemovable = true;
        style = {
          wallpapers = [ /home/hehs/Pictures/wallpapers/dream-purple.png ];
          wallpaperStyle = "stretched";
          graphicalTerminal = {
            background = "ff000000";
            margin = 0;
            marginGradient = 0;
          };
        };
      };
    };
  };
  time.timeZone = "Europe/Moscow";
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
  programs = {
    firefox.enable = true;
    niri.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    throne = {
      enable = true;
      tunMode = {
        enable = true;
        setuid = true;
      };
    };
  };
  services = {
    happ.enable = true;
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };  
  };
  environment = {
    variables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch";
      edit = "sudo hx /etc/nixos/configuration.nix";
    };
    gnome.excludePackages = with pkgs; [
      gnome-user-docs
      gnome-contacts
      gnome-calendar
      gnome-weather
      gnome-clocks
      gnome-music
      gnome-maps
      gnome-tour
      epiphany
      yelp
    ];
    systemPackages = with pkgs; [
      unstable.amnezia-vpn
      wl-gammarelay-rs
      wl-clipboard
      gnome-boxes
      freshfetch
      obs-studio
      rustdesk
      sing-box
      ddcutil
      python3
      micro
      delta
      helix
      nixd
      curl
      wget
      htop
      dbus
      just
      yazi
      git
      unstable.uv
  
      # for helix LSP
      unstable.ruff
      unstable.ty
      nil
      nixfmt
      rust-analyzer
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server
      taplo
      kdlfmt
      kdl-lsp
      marksman
      markdown-oxide

      # niri
      xwayland-satellite 
      alacritty
      fuzzel
      waybar
      hyprlock

      ];
  };
  users.users.hehs = {
    isNormalUser = true;
    description = "Ислам Асабаев";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "i2c" ];
    packages = with pkgs; [
      onlyoffice-desktopeditors
      gnomeExtensions.pano
      telegram-desktop
      faugus-launcher
      gnome-tweaks
      vulkan-tools
      thunderbird
      zed-editor
      obsidian
      lutris
      vscode
      codex
      gh
    ];
  };
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans      # китайский/японский/корейский
      noto-fonts-color-emoji   # эмодзи
      liberation_ttf           # метрически совместимы с Arial/Times/Courier
      fira-code
      jetbrains-mono
      nerd-fonts.jetbrains-mono  # иконки для терминала/панелей
      nerd-fonts.symbols-only
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" "Liberation Serif" ];
        sansSerif = [ "Noto Sans" "Liberation Sans" ];
        monospace = [ "JetBrains Mono" "Noto Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

}

