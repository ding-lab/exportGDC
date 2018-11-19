CASES="dat/cases.dat"
BAMMAP="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/katmai.BamMap.dat"
OUT="dat/katmai.LUAD-UCEC.hg38.WXS.BamMap.dat"

# BamMap columns
#     1  SampleName
#     2  Case
#     3  Disease
#     4  ExpStrategy
#     5  SampType
#     6  DataPath
#     7  FileSize
#     8  DataFormat
#     9  Reference
#    10  UUID


# Keep only hg38 WXS tumor and blood normal samples
head -n1 $BAMMAP > $OUT
grep -f $CASES $BAMMAP | awk 'BEGIN{FS="\t";OFS="\t"}{if ($4 ~ "WXS" && $9 ~ "hg38" && ($5 ~ "tumor" || $5 ~ "blood_normal")) print}' >> $OUT

SIZE=$(cut -f 7 $OUT | grep -v UUID | bash ../export_utils/sumGb.sh)

echo Written to $OUT
echo Total size $SIZE
