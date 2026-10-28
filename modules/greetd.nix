{ pkgs, ... }:


{
  # Настройки boot позволяет убрать всплывающие логи при входе
  boot.consoleLogLevel = 0;
  boot.kernelParams = [ "queit" "loglevel=0"];
  boot.kernel.sysctl."kernel.printk" = "0 0 0 0";

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
         ${pkgs.tuigreet}/bin/tuigreet
           --time
           --remember
           --remember-session
           --asterisks
           # Проблема с "Calling import-environment without a list of variable names is deprecated":
           # https://github.com/niri-wm/niri/pull/3572
           --cmd niri-session
        '';
        user = "greeter";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
    ExecStartPre = "-${pkgs.util-linux}/bin/kill -55 1";
    ExecStopPost = "-${pkgs.util-linux}/bin/kill -54 1";
  };
}
