# Delete all UUIDs which are found in BamMap but not AR
UUID="dat/BM_ONLY.uuid.dat"
BAMMAP="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/katmai.BamMap.dat"
NEWBAMMAP="dat/NEW.katmai.BamMap.dat"

#bash ../importGDC/BamMap.rm.sh -v -B $BAMMAP $TESTUUID > $NEWBAMMAP

cat $UUID | bash BMUtils/BamMap.rm.sh $@ -v -B $BAMMAP - > $NEWBAMMAP


echo Written to $NEWBAMMAP
