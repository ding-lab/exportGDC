# get list of all katmai WGS UUID

CATALOGD="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog"

KATMAI_BM="$CATALOGD/BamMap/katmai.BamMap.dat"
OUT="dat/katmai-WGS.UUID.dat"
mkdir -p dat


grep WGS $KATMAI_BM | cut -f 10 | sort -u > $OUT

>&2 echo Written to $OUT
