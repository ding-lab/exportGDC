BAMMAP="/Users/mwyczalk/Projects/CPTAC3/CPTAC3.catalog/BamMap/katmai.BamMap.dat"
CATALOG="/Users/mwyczalk/Projects/CPTAC3/CPTAC3.catalog/CPTAC3.Catalog.dat"
OUTPUT="dat/katmai.BamMap.20201109.fix_sample_names.dat"

mkdir -p dat
bash fix_sample_names.sh $BAMMAP $CATALOG > $OUTPUT
>&2 echo Original BAMMAP = $BAMMAP
>&2 echo Corrected BAMMAP = $OUTPUT
