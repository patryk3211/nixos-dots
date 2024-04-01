{ config, pkgs, ... }:

{
  home.packages = [ config.theme.qt.package ];

  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "kvantum";
    };
  };

  xdg.configFile = let
    qtConfig = version: ''
      [Appearance]
      icon_theme=${config.theme.icon.name}
      style=kvantum

      [Fonts]
      fixed="Fira Mono,12,-1,5,50,0,0,0,0,0"
      general="Exo 2,12,-1,5,57,0,0,0,0,0"

      [Interface]
      activate_item_on_single_click=0
      buttonbox_layout=0
      cursor_flash_time=1000
      dialog_buttons_have_icons=1
      double_click_interval=400
      gui_effects=General, AnimateMenu, AnimateCombo, AnimateTooltip, AnimateToolBox
      keyboard_scheme=2
      menus_have_icons=true
      stylesheets=/home/patryk/.nix-profile/share/qt${toString version}ct/qss/fusion-fixes.qss, /home/patryk/.nix-profile/share/qt${toString version}ct/qss/scrollbar-simple.qss, /home/patryk/.nix-profile/share/qt${toString version}ct/qss/sliders-simple.qss, /home/patryk/.nix-profile/share/qt${toString version}ct/qss/tooltip-simple.qss, /home/patryk/.nix-profile/share/qt${toString version}ct/qss/traynotification-simple.qss
      show_shortcuts_in_context_menus=true
      toolbutton_style=4
      underline_shortcut=1
      wheel_scroll_lines=3
    '';
  in {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=${config.theme.qt.name}
    '';

    "qt5ct/qt5ct.conf".text = (qtConfig 5);
    "qt6ct/qt6ct.conf".text = (qtConfig 6);
  };
}
