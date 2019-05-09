# Obtain UUIDs for all data of interest
AR="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/CPTAC3.AR.dat"
BAMMAP="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/katmai.BamMap.dat"

UUID_BM="dat/BamMap.uuid.dat"
UUID_AR="dat/AR.uuid.dat"
UUID_BM_ONLY="dat/BM_ONLY.uuid.dat"

grep -v "UUID" $AR | cut -f 10 | sort -u > $UUID_AR
grep -v "UUID" $BAMMAP | cut -f 10 | sort -u > $UUID_BM

# Obtain the UUID which are unique to BamMap
comm -13 $UUID_AR $UUID_BM > $UUID_BM_ONLY

echo Written to $UUID_BM_ONLY
