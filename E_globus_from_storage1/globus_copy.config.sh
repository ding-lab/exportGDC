# Definitions for globus copy

# Arbitrary label for this transfer
LABEL="Storage1 to MGI - 20210302"

# In a globus transfer it is helpful to think of three independent systems:
# * GLOBUS_SYS - this is the system where execution of these scripts is taking place
# * SOURCE_SYS - source of globus transfer
# * DEST_SYS   - target of globus transfer

# Note about SYSTEM names
# * DOCKER_SYSTEM - one of MGI, compute1, docker
#     used by start_docker.sh to initialize appropriately
#     use this for GLOBUS_SYS
# * FILE_SYSTEM - one of MGI, storage1, katmai
#     used in creation of BamMaps to indicate where data stored
#     use this for SOURCE_SYS and DEST_SYS

# Data download root directory.  Individual BAMS/FASTQs will be in,
#   $DATA_ROOT/GDC_import/data/<UUID>/<FILENAME>
# BAM files will have a <FILENAME>.bai and <FILENAME>.flagstat written as well

# Master BamMap file is not modified by any scripts

## GLOBUS_SYS
GLOBUS_SYS="MGI"
START_DOCKERD="/gscuser/mwyczalk/projects/WUDocker" # git clone https://github.com/ding-lab/WUDocker.git
CATALOGD="/gscuser/mwyczalk/projects/CPTAC3/CPTAC3.catalog"

## SOURCE_SYS
SOURCE_SYS="storage1"
SRC_DIR="/storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/CPTAC3-GDC/GDC_import/data/"

## DEST_SYS
DEST_SYS="MGI"
DEST_DIR="/gscmnt/gc2619/dinglab_cptac3/GDC_import/data/"

# katmai
# CATALOGD="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog"
# DATA_ROOT="/diskmnt/Projects/cptac"
# START_DOCKERD="/home/mwyczalk_test/Projects/WUDocker"
# FILE_SYSTEM="katmai"
# DOCKER_SYSTEM="docker"

# MGI
# CATALOGD="/gscuser/mwyczalk/projects/CPTAC3/CPTAC3.catalog"
# DATA_ROOT="/gscmnt/gc2619/dinglab_cptac3"
# START_DOCKERD="/gscuser/mwyczalk/projects/WUDocker" # git clone https://github.com/ding-lab/WUDocker.git
# FILE_SYSTEM="MGI"
# DOCKER_SYSTEM="MGI"

# compute1
#CATALOGD="/storage1/fs1/dinglab/Active/Projects/CPTAC3/Common/CPTAC3.catalog"
#DATA_ROOT="/storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/CPTAC3-GDC"
#START_DOCKERD="/storage1/fs1/home1/Active/home/m.wyczalkowski/Projects/WUDocker" # git clone https://github.com/ding-lab/WUDocker.git
#FILE_SYSTEM="storage1"
#DOCKER_SYSTEM="compute1"

# Format for batch file: 
# --recursive UUID UUID
BATCH_FILE="dat/batch.UUID_to_copy.dat"
UUIDS="dat/UUID_to_copy.dat"

CATALOG_MASTER="$CATALOGD/CPTAC3.Catalog.dat"
BAMMAP_SOURCE="$CATALOGD/BamMap/${SOURCE_SYS}.BamMap.dat"   # note this is a path on GLOBUS_SYS to the source system BamMap
BAMMAP_DEST="$CATALOGD/BamMap/${DEST_SYS}.BamMap.dat"       # note this is a path on GLOBUS_SYS to the destination system BamMap
CASES_MASTER="$CATALOG/CPTAC3.cases.dat"

# This file is generated in step 2 as a subset of CATALOG_MASTER
# It is no longer used to drive the workflow but remains for convenience
CATALOG_NEW="dat/New.Catalog.dat"

## BAMMAP is created as the final step of import process.
#BAMMAP_NEW="dat/${DEST_SYS}.New.BamMap.dat"

# Globus endpoints

#globus endpoint search "Wash U RIS storage1 dtn1"
#ID                                   | Owner              | Display Name
#------------------------------------ | ------------------ | ------------------------
#01f0ac4c-9570-11ea-b3c4-0ae144191ee3 | wustl@globusid.org | Wash U RIS storage1 dtn1
#globus endpoint search "MGI storage0"
#ID                                   | Owner              | Display Name
#------------------------------------ | ------------------ | -------------------------------
#e66a20e4-aaf1-11e8-970a-0a6d4e044368 | wustl@globusid.org | MGI storage0 data transfer node

### Remembering these
STORAGE_0_ID=e66a20e4-aaf1-11e8-970a-0a6d4e044368
STORAGE_1_ID=01f0ac4c-9570-11ea-b3c4-0ae144191ee3

