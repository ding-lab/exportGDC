source globus_copy.config.sh


SRC_DIR="/storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/CPTAC3-GDC/GDC_import/data/"
DEST_DIR="/gscmnt/gc2619/dinglab_cptac3/GDC_import/data/"

# Command line options: https://docs.globus.org/cli/reference/transfer/
# 
#ARGS="--dry-run"

cat $BATCH_FILE | globus transfer $STORAGE_1_ID:$SRC_DIR $STORAGE_0_ID:$DEST_DIR --batch --label "$LABEL" $ARGS

