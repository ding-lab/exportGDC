# Obtain UUIDs for all data of interest
BAMMAP="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/katmai.BamMap.dat"
CASES="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/CPTAC3.cases.dat"
mkdir -p dat
OUT="dat/UUIDs_of_interest.dat"



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

echo Writing to $OUT
grep -f <(grep "Y2.b1" $CASES | cut -f 1 ) $BAMMAP | awk '{if ($4 == "WXS" && $9 == "hg38") print $10}' | sort > $OUT

# Now check to see if any of these already exist at MGI
# First, get all Y2.b1 UUIDs at MGI
OUT2="dat/UUIDs_at_MGI.dat"
MGI_BM="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/MGI.BamMap.dat"
>&2 echo Writing to $OUT2
grep -f <(grep "Y2.b1" $CASES | cut -f 1 ) $MGI_BM | cut -f 10  | sort -u > $OUT2

# Recall:
# comm [OPTION]... FILE1 FILE2
#       Compare sorted files FILE1 and FILE2 line by line.
#       -1     suppress column 1 (lines unique to FILE1)
#       -2     suppress column 2 (lines unique to FILE2)
#       -3     suppress column 3 (lines that appear in both files)

OUT_DL="dat/UUIDs_to_download.dat"
# We want the UUID that are unique to katmai, so...
# comm -1 katmai_UUID MGI_UUID 

>&2 echo Comparing $OUT and $OUT2, writing to $OUT_DL
comm -23 $OUT $OUT2 > $OUT_DL




SUMSIZE=$(grep -f $OUT_DL $BAMMAP | cut -f 7 | bash BMUtils/sumGb.sh)
COUNT=$(wc -l $OUT_DL | cut -f 1 -d ' ')

echo Planning to copy $SUMSIZE in $COUNT files
