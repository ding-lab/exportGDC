UUID_DELETE="/storage1/fs1/dinglab/Active/Projects/cliu/GBM_confirmatory/remove_from_bammap/20220427_GBM_673/UUID.txt"

# MGI
#CATALOGD="/gscuser/mwyczalk/projects/CPTAC3/CPTAC3.catalog"     # MGI paths
#SYSTEM="MGI"

#CATALOGD="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog"  # katmai paths

# Compute1
CATALOGD="/storage1/fs1/dinglab/Active/Projects/CPTAC3/Common/CPTAC3.catalog"
SYSTEM="storage1"

BM="$CATALOGD/BamMap/${SYSTEM}.BamMap.dat"
NEW_BM="dat/${SYSTEM}.BamMap.post-delete.dat"

mkdir -p dat

cat $UUID_DELETE | bash BMUtils/BamMap.rm.sh $@ -v -B $BM - > $NEW_BM
echo Original BamMap: $BM
echo Updated BamMap:  $NEW_BM

