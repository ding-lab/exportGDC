# Obtain UUIDs for all miRNA data BAMMAP="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/denali.BamMap.dat"
BAMMAP="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/denali.BamMap.dat"
mkdir -p dat
OUT="dat/UUIDs_to_download.dat"

awk '{if ($4 == "miRNA-Seq" ) print $10}' $BAMMAP | sort > $OUT

echo Writing to $OUT

SUMSIZE=$(grep -f $OUT $BAMMAP | cut -f 7 | bash BMUtils/sumGb.sh)
COUNT=$(wc -l $OUT | cut -f 1 -d ' ')

echo Planning to copy $SUMSIZE in $COUNT files
