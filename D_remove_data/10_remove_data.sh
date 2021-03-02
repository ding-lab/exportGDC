UUID_DELETE="../E_globus_from_storage1/dat/UUID_to_copy.dat"

# MGI
CATALOGD="/gscuser/mwyczalk/projects/CPTAC3/CPTAC3.catalog"
ECATALOGD="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog"

BM="$CATALOGD/BamMap/MGI.BamMap.dat"
NEW_BM="dat/MGI.BamMap.post-delete.dat"

mkdir -p dat

cat $UUID_DELETE | bash BMUtils/BamMap.rm.sh $@ -v -B $BM - > $NEW_BM
echo Original BamMap: $BM
echo Updated BamMap:  $NEW_BM

