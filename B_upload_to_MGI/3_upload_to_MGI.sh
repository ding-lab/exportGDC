source export.config.sh

bash BMUtils/upload_BM.sh -v -B $BAMMAP -S $AR -R $REMOTED -H $RHOST $@ - < $UUIDS
