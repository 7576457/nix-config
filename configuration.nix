{ config, pkgs, ... }:


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
      wl-clipboard
      gnome-boxes
      freshfetch
      obs-studio
      rustdesk
      sing-box
      ddcutil
      python3
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
      uv
  
      # for helix LSP
      unstable.ruff
      unstable.ty
      nil
      nixfmt
      rust-analyzer
      typescript-language-server
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
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      font-awesome
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["JetBrainsMono Nerd Font" "Dejavu Sans Mono"];
      };
    };
  };
}

