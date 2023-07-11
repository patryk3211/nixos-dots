{ config, pkgs, ... }: let
  sshKey = "keepassftp";
  secretsFile = "${config.home.homeDirectory}/keepass/secrets";

  localFile = "${config.home.homeDirectory}/keepass/passwords.kdbx";
  remoteFile = "keepass/passwords.kdbx";

  syncScript = pkgs.writeShellScript "keepass-sync-script" ''
    source ${secretsFile}
    SSH_KEY=${config.home.homeDirectory}/.ssh/${sshKey}

    function download_db() {
      echo "Downloading database"
      printf "get %s %s\nexit\n" "${remoteFile}" "${localFile}" |
        ${pkgs.openssh}/bin/sftp -i $SSH_KEY $REMOTE_USER@$REMOTE_ADDRESS
    }

    function upload_db() {
      echo "Uploading database"
      printf "put %s %s\nexit\n" "${localFile}" "${remoteFile}" |
        ${pkgs.openssh}/bin/sftp -i $SSH_KEY $REMOTE_USER@$REMOTE_ADDRESS &&
        ${pkgs.dunst}/bin/dunstify "Database uploaded" "KeepassXC database successfully uploaded to remote server" ||
        ${pkgs.dunst}/bin/dunstify "Database upload failed" "Failed to upload KeepassXC database to remote server" -u critical
    }

    download_db

    dbPath="${localFile}"
    dbDir=''${dbPath%/*}
    dbFile=''${dbPath##*/}

    ${pkgs.inotify-tools}/bin/inotifywait -e close_write,moved_to,create -m $dbDir |
      while read -r directory events filename; do
        if [ "$filename" = "$dbFile" ]; then
          upload_db
        fi
      done
  '';
in {
  home.packages = with pkgs; [
    keepassxc
  ];

  systemd.user.services.keepass_sync = {
    Unit = {
      Description = "Keepass database sync daemon";
      PartOf = [ "default.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.bash}/bin/bash ${syncScript.outPath}";
    };
  };
}
