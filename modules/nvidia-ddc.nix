# NVIDIA: драйвер с открытыми модулями ядра (Turing и новее),
# modesetting для Wayland, OpenGL/Vulkan с поддержкой 32-битных приложений.
{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    nvidia = {
      open = true; 
      modesetting.enable = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
  boot.kernelParams = [ "nvidia.NVreg_RegistryDwords=RMUseHexVcCaps=1" ];
}
