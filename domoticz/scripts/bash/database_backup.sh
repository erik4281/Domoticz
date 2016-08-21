#!/bin/bash
# LOCAL/FTP/SCP/MAIL PARAMETERS

SERVER="10.0.1.200"      # IP of Network disk, used for ftp
USERNAME="admin"         # FTP username of Network disk used for ftp
PASSWORD="WdMyCloud4TB"  # FTP password of Network disk used for ftp
DESTDIR="/erik/Domoticz"    # used for temorarily storage
DOMO_IP="10.0.1.120"     # Domoticz IP 
DOMO_PORT="8080"         # Domoticz port 

### END OF USER CONFIGURABLE PARAMETERS

TIMESTAMP=`/bin/date +%Y%m%d%H%M%S`
BACKUPFILE="domoticz_$TIMESTAMP.db" # backups will be named "domoticz_YYYYMMDDHHMMSS.db.gz"
BACKUPFILEGZ="$BACKUPFILE".gz

### Create backup and ZIP it

/usr/bin/curl -s http://$DOMO_IP:$DOMO_PORT/backupdatabase.php > /tmp/$BACKUPFILE
gzip -9 /tmp/$BACKUPFILE

### Send to Network disk through FTP

curl -s --disable-epsv -v -T"/tmp/$BACKUPFILEGZ" -u"$USERNAME:$PASSWORD" "ftp://$SERVER/media/hdd/Domoticz_backup/"				

### Remove temp backup file

/bin/rm /tmp/$BACKUPFILEGZ

### Done!
