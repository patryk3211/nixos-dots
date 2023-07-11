{ config, pkgs, ... }:
let
  browser = [ "firefox.desktop" ];

  vlc = [ "vlc.desktop" ];
  image = [ "com.github.weclaw1.ImageRoll.desktop" ];
  filemanager = [ "nnn.desktop" ];
  pdf = [ "atril.desktop" ];
  texteditor = [ "nvim.desktop" ];
  archiver = [ "org.gnome.FileRoller.desktop" ];
in {
  home.packages = with pkgs; [
    xdg-utils
  ];

  xdg = {
    enable = true;
    mime.enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/x-extension-xht" = browser;
        "application/x-extension-xhtml" = browser;
        "application/xhtml+xml" = browser;
        "text/html" = browser;
        
        "x-scheme-handler/about" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;

        "audio/*" = vlc;
        "video/*" = vlc;
        "image/*" = image;

        "application/x-directory" = filemanager;
        "text/directory" = filemanager;
	"inode/directory" = filemanager;

	"applications/pdf" = pdf;

	"text/*" = texteditor;

	"application/gzip" = archiver;
	"application/x-tar" = archiver;
	"application/zip" = archiver;
	"application/x-7z-compressed" = archiver;
	"application/x-bzip" = archiver;
	"application/x-bzip2" = archiver;
	"application/vnd.rar" = archiver;

	"application/msword" = [ "writer.desktop" ];
	"application/vnd-openxmlformats-officedocument.wordprocessingml.document" = [ "writer.desktop" ];
	"application/vnd.ms-powerpoint" = [ "impress.desktop" ];
	"application/vnd-openxmlformats-officedocument.presentationml.presentation" = [ "impress.desktop" ];
	"application/vnd.ms-excel" = [ "calc.desktop" ];
	"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [ "calc.desktop" ];
      };
    };
  };
}
