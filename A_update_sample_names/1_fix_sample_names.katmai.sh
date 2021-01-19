BAMMAP="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/BamMap/katmai.BamMap.dat"
CATALOG="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/CPTAC3.Catalog.dat"
OUTPUT="dat/katmai.BamMap.20210119.fix_sample_names.dat"

mkdir -p dat
bash fix_sample_names.sh $BAMMAP $CATALOG > $OUTPUT
>&2 echo Original BAMMAP = $BAMMAP
>&2 echo Corrected BAMMAP = $OUTPUT
