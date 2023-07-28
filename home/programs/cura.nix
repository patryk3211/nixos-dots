{ pkgs, ... }: let
  package = pkgs.appimageTools.wrapType2 {
    name = "ultimaker-cura";
    src = pkgs.fetchurl {
      url = "https://github.com/Ultimaker/Cura/releases/download/5.4.0/UltiMaker-Cura-5.4.0-linux-modern.AppImage";
      sha256 = "1gkp37vgqq7hi9yxmy5n2bdjvnzg06dsxym93y7wvlz88xdgnns1";
    };
  };
in {
  home.packages = [ package ];

  xdg.desktopEntries."Ultimaker" = {
    name = "Ultimaker Cura";
    genericName = "3D Printing Software";
    exec = "${package}/bin/ultimaker-cura %F";
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
