BAMMAP="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/denali.BamMap.dat"
SR="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/CPTAC3.SR.dat"
UUIDS="dat/UUIDs_to_download.dat"

LOCALD="/diskmnt/Projects/cptac_downloads/data"
STAGE_ROOT_REMOTE="/diskmnt/Projects/cptac_downloads_1"
REMOTED="$STAGE_ROOT_REMOTE/GDC_import/data" 
RHOST="mwyczalk_test@10.22.24.2"  # katmai


bash BMUtils/upload_BM.sh -v -B $BAMMAP -S $SR -L $LOCALD -R $REMOTED -H $RHOST $@ - < $UUIDS
