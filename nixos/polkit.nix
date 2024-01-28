{ ... }: {
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if(subject.isInGroup("storage")) {
          // Allow all udisks2 actions for users in storage group
          if(action.id.startsWith("org.freedesktop.udisks2.")) {
            return polkit.Result.YES;
          }

          // Allow all udisks actions for users in storage group
          if(action.id.startsWith("org.freedesktop.udisks.")) {
            return polkit.Result.YES;
          }
        }
      });
    '';
    # extraConfig = ''
    #   polkit.addRule(function(action, subject) {
    #     var YES = polkit.Result.YES;
    #     var permission = {
    #       // required for udisks1:
    #       "org.freedesktop.udisks.filesystem-mount": YES,
    #       "org.freedesktop.udisks.luks-unlock": YES,
    #       "org.freedesktop.udisks.drive-eject": YES,
    #       "org.freedesktop.udisks.drive-detach": YES,
    #       // required for udisks2:
    #       "org.freedesktop.udisks2.filesystem-mount": YES,
    #       "org.freedesktop.udisks2.encrypted-unlock": YES,
    #       "org.freedesktop.udisks2.eject-media": YES,
    #       "org.freedesktop.udisks2.power-off-drive": YES,
    #       // required for udisks2 if using udiskie from another seat (e.g. systemd):
    #       "org.freedesktop.udisks2.filesystem-mount-other-seat": YES,
    #       "org.freedesktop.udisks2.filesystem-unmount-others": YES,
    #       "org.freedesktop.udisks2.encrypted-unlock-other-seat": YES,
    #       "org.freedesktop.udisks2.encrypted-unlock-system": YES,
    #       "org.freedesktop.udisks2.eject-media-other-seat": YES,
    #       "org.freedesktop.udisks2.power-off-drive-other-seat": YES
    #     };
    #     if (subject.isInGroup("storage")) {
    #       return permission[action.id];
    #     }
    #   });
    # '';
  };
}