# Make UUID list.  This can be made in an earlier step
# Used for examine_import on MGI

BAMMAP="dat/katmai.LUAD-UCEC.hg38.WXS.BamMap.dat"
OUT="dat/LUAD-UCEC.hg38.WXS.uuid.dat"

cut -f 10 $BAMMAP | grep -v UUID | sort > $OUT
echo Written to $OUT
