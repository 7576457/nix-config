{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  time.timeZone = "Europe/Moscow";

  nixpkgs.config.allowUnfree = true;

  systemd.user.services.soteria = {
    description = "Soteria polkit authentication agent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.soteria}/bin/soteria";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  users.users.hehs= {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "libvirtd"
      "networkmanager"        
      "wheel"        
    ];
    packages = with pkgs; [
      obsidian
      telegram-desktop
      thunderbird
      vscode
    ];
  };

  system.stateVersion = "26.11";
}

