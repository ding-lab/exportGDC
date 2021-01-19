BAMMAP="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/BamMap/MGI.BamMap.dat"
CATALOG="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/CPTAC3.Catalog.dat"
OUTPUT="dat/MGI.BamMap.20210119.fix_sample_names.dat"

mkdir -p dat
bash fix_sample_names.sh $BAMMAP $CATALOG > $OUTPUT
>&2 echo Original BAMMAP = $BAMMAP
>&2 echo Corrected BAMMAP = $OUTPUT
