BAMMAP="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/katmai.BamMap.dat"
mkdir -p dat
BM_NEW="dat/katmai.BamMap-new.dat"

# BAD: 
#   /diskmnt/Projects/cptac_downloads_1
#   /diskmnt/Projects/cptac_downloads_2
#   /diskmnt/Projects/cptac_downloads_3
#   /diskmnt/Projects/cptac_downloads_5
# Replace with: /diskmnt/Projects/cptac3_primary_1/

cat $BAMMAP | \
sed "s+/diskmnt/Projects/cptac_downloads_1+/diskmnt/Projects/cptac3_primary_1+" | \
sed "s+/diskmnt/Projects/cptac_downloads_2+/diskmnt/Projects/cptac3_primary_1+" | \
sed "s+/diskmnt/Projects/cptac_downloads_3+/diskmnt/Projects/cptac3_primary_1+" | \
sed "s+/diskmnt/Projects/cptac_downloads_5+/diskmnt/Projects/cptac3_primary_1+" > $BM_NEW

echo Written to $BM_NEW



