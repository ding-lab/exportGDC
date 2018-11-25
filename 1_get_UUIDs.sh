# Obtain UUIDs for all data of interest
BAMMAP="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/katmai.BamMap.dat"
mkdir -p dat
OUT="dat/UUIDs_to_download.dat"

#     1   # sample_name
#     2  case
#     3  disease
#     4  experimental_strategy
#     5  sample_type
#     6  data_path
#     7  filesize
#     8  data_format
#     9  reference
#    10  UUID
#    11  system

awk '{if ($4 == "WXS" && $3 == "GBM" && $9 == "hg38") print $10}' $BAMMAP | sort > $OUT

echo Writing to $OUT

SUMSIZE=$(grep -f $OUT $BAMMAP | cut -f 7 | bash BMUtils/sumGb.sh)
COUNT=$(wc -l $OUT | cut -f 1 -d ' ')

echo Planning to copy $SUMSIZE in $COUNT files
