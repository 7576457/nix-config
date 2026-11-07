{
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    pulseaudio.enable = false;
    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
    qemuGuest.enable = true;
    printing.enable = true;
    fwupd.enable = true;
    dbus.enable = true;
    sing-box.enable = true;
  };
}
