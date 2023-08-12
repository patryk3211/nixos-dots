{ config, lib, pkgs, ... }: let
  nvidiaX11 = config.boot.kernelPackages.nvidia_x11;
  xorg = pkgs.xorg.xorgserver;

  xorgConf = pkgs.writeText "xorg.conf" ''
    Section "Files"
      ModulePath "${nvidiaX11.bin}/lib/xorg/modules/drivers"
      ModulePath "${nvidiaX11.bin}/lib/xorg/modules/extensions"

      ModulePath "${pkgs.xorg.xf86inputlibinput}"

      ModulePath "${xorg}/lib/xorg/modules"
      ModulePath "${xorg}/lib/xorg/modules/drivers"
      ModulePath "${xorg}/lib/xorg/modules/extensions"
      ModulePath "${xorg}/lib/xorg/modules/input"
    EndSection

    Section "ServerLayout"
      Identifier "Layout[all]"

      Screen "Screen-nvidia"
    EndSection

    Section "InputClass"
      Identifier "keyboard[all]"
      MatchIsKeyboard "on"
      Option "XkbModel" "pc104"
      Option "XkbLayout" "us"
      Option "XkbOptions" "terminate:ctrl_alt_bksp"
      Option "XkbVariant" ""
    EndSection

    Section "InputClass"
      Identifier "evdev keyboard catchall"
      MatchIsKeyboard "on"
      MatchDevicePath "/dev/input/event*"
      Driver "evdev"
    EndSection

    Section "InputClass"
      Identifier "libinput keyboard catchall"
      MatchIsKeyboard "on"
      MatchDevicePath "/dev/input/event*"
      Driver "libinput"
    EndSection

    Section "Device"
      Identifier "Nvidia-GPU"
      Driver "nvidia"
      Option "Coolbits" "28"
      Option "AllowEmptyInitialConfiguration"
    EndSection

    Section "Monitor"
      Identifier "Monitor[0]"
      Option "IgnoreEDID"
    EndSection

    Section "Screen"
      Identifier "Screen-nvidia"
      Monitor "Monitor[0]"
      Device "Nvidia-GPU"
    EndSection
  '';

  xExec = "${xorg}/bin/X";

  nvCfg = "${nvidiaX11.settings}/bin/nvidia-settings";
  
  display = 100;

  xinitSrc = pkgs.writeText ".xinitrc" ''
    ${pkgs.kbd}/bin/chvt 1

    # Apply overclock settings
    ${nvCfg} -a "[gpu:0]/GPUGraphicsClockOffsetAllPerformanceLevels=150"
    ${nvCfg} -a "[gpu:0]/GPUMemoryTransferRateOffsetAllPerformanceLevels=200"

    # exec ${nvCfg}
  '';
in {

  systemd.services."nvidia-x" = {
    script = ''
      ${pkgs.xorg.xinit}/bin/xinit ${pkgs.bash}/bin/bash ${xinitSrc} -- ${xExec} :${toString display} vt7 -novtswitch -nolisten tcp -config ${xorgConf}
    '';
  };

}
