{
  programs = {
    firefox.enable = true;
    git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
        core.pager = "delta";
        interactive.diffFilter = "delta --color-only";
        delta.navigate = true;
      };
    };
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    niri = {
      enable = true;
      useNautilus = true;
    };
    waybar.enable = true;
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "alacritty";
    };
    dconf.enable = true;
    htop.enable = true; 
    throne = {
      enable = true;
      tunMode = {
        enable = true;
        setuid = true;
      };
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    gamemode.enable = true;
  };
}
