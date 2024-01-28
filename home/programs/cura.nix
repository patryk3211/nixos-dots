{ pkgs, ... }: let
  package = (pkgs.appimageTools.wrapType2 {
    name = "ultimaker-cura";
    src = pkgs.fetchurl {
      url = "https://github.com/Ultimaker/Cura/releases/download/5.6.0/UltiMaker-Cura-5.6.0-linux-X64.AppImage";
      sha256 = "107896a0da4b2873f3bfaad9aed36012bef2fff89571161e57f4da0a7f10a440";
    };
    extraPkgs = pkgs: with pkgs; [ util-linux ];
  });
  packageWithEnv = pkgs.symlinkJoin {
    name = "ultimaker-cura-withenv";
    paths = [ package ];
    buildInputs = [
      pkgs.makeWrapper
    ];
    postBuild = ''
      wrapProgram "$out/bin/ultimaker-cura" \
        --set QT_QPA_PLATFORM "xcb" \
        --set QT_STYLE_OVERRIDE "" \
        --prefix PATH : ${pkgs.util-linux}/bin
      '';
  };
in {
  home.packages = [ packageWithEnv ];

  xdg.desktopEntries."Ultimaker" = {
    name = "Ultimaker Cura";
    genericName = "3D Printing Software";
    exec = "${packageWithEnv}/bin/ultimaker-cura %F";
    type = "Application";
    icon = "cura-icon";
    terminal = false;
    categories = [ "Graphics" ];
    mimeType = [ "model/stl" "application/vnd.ms-3mfdocument" "application/x-amf" "application/x-ply" "application/x-ctm" "model/vnd.collada+xml" "model/vnd.collada+xml+zip" ];
    settings = {
      Keywords = "3D;Printing;Slicer;";
      StartupWMClass = "cura.real";
    };
  };
}
