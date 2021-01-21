UUID_DELETE="dat/WGS.katmai_storage1_common.dat"
BM="/diskmnt/Projects/cptac_scratch/CPTAC3.workflow/CPTAC3.catalog/BamMap/katmai.BamMap.dat"
NEW_BM="dat/katmai.BamMap.post-delete.dat"

cat $UUID_DELETE | bash src/BamMap.rm.sh $@ -v -B $BM - > $NEW_BM
echo Written to $NEW_BM

