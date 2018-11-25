source export.config.sh

bash BMUtils/upload_BM.sh -v -B $BAMMAP -S $SR -R $REMOTED -H $RHOST $@ - < $UUIDS
