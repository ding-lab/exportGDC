#globus endpoint search "Wash U RIS storage1 dtn1"
#ID                                   | Owner              | Display Name
#------------------------------------ | ------------------ | ------------------------
#01f0ac4c-9570-11ea-b3c4-0ae144191ee3 | wustl@globusid.org | Wash U RIS storage1 dtn1
#globus endpoint search "MGI storage0"
#ID                                   | Owner              | Display Name
#------------------------------------ | ------------------ | -------------------------------
#e66a20e4-aaf1-11e8-970a-0a6d4e044368 | wustl@globusid.org | MGI storage0 data transfer node

# TODO: add these to globus_copy.config.sh
### Remembering these
S0=e66a20e4-aaf1-11e8-970a-0a6d4e044368
S1=01f0ac4c-9570-11ea-b3c4-0ae144191ee3



SRC_DIR="/storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/CPTAC3-GDC/GDC_import/data/"
DEST_DIR="/gscmnt/gc2619/dinglab_cptac3/GDC_import/data/"
UUID="dat/UUID_copy_from_storage1.batch_file.dat"   # this has destination and target directories
LABEL="Storage1 to MGI - 20210210"

# Command line options: https://docs.globus.org/cli/reference/transfer/
# 
cat $UUID | globus transfer $S1:$SRC_DIR $S0:$DEST_DIR --batch --label "$LABEL"

