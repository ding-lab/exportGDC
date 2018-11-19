DAT="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/CPTAC3.C325.cases.dat"
mkdir -p dat
OUT="dat/cases.dat"

awk '{if ($2 ~ "LUAD" || $2 ~ "UCEC" ) print}' $DAT | cut -f 1 > $OUT

echo Writing to $OUT
