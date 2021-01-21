UUID_DELETE="dat/katmai-WGS.UUID.dat"
CATALOGD="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog"
BM="$CATALOGD/BamMap/katmai.BamMap.dat"
NEW_BM="dat/katmai.BamMap.post-delete.dat"

cat $UUID_DELETE | bash BMUtils/BamMap.rm.sh $@ -v -B $BM - > $NEW_BM
echo Original BamMap: $BM
echo Updated BamMap:  $NEW_BM

