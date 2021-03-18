UUID_DELETE="../D_globus_from_storage1/dat/UUID_to_copy.dat"

# MGI
CATALOGD="/gscuser/mwyczalk/projects/CPTAC3/CPTAC3.catalog"     # MGI paths
SYSTEM="MGI"

#CATALOGD="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog"  # katmai paths

BM="$CATALOGD/BamMap/${SYSTEM}.BamMap.dat"
NEW_BM="dat/${SYSTEM}.BamMap.post-delete.dat"

mkdir -p dat

cat $UUID_DELETE | bash BMUtils/BamMap.rm.sh $@ -v -B $BM - > $NEW_BM
echo Original BamMap: $BM
echo Updated BamMap:  $NEW_BM

