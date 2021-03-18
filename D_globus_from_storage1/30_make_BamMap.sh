# Create a BamMap for remote system
# This is done by replacing the path and system columns 

source globus_copy.config.sh

mkdir -p dat

OUT_BM="dat/${DEST_SYS}.BamMap.globus_copy.dat"
OUT_BM_MERGED="dat/${DEST_SYS}.BamMap.merged.dat"

# Write header
grep "^#" $BAMMAP_SOURCE | head -n 1 > $OUT_BM

# for each UUID, obtain source BamMap entry.  To write destination BamMap, replace the filename and system columns
# filename is obtained from the filename and parent directory of the source path, with destination path prepended

while read UUID; do
    # Skip comments and header
    [[ $UUID = \#* ]] && continue
    >&2 echo $UUID

    BM_LINE=$(grep $UUID $BAMMAP_SOURCE)
    LFN=$(echo "$BM_LINE" | cut -f 6)
    >&2 echo Source FN = $LFN
    FN="$(basename $LFN)"
    RFN="$DEST_DIR/$UUID/$FN"
    >&2 echo Destination FN = $RFN

# BamMap columns:
#     1  sample_name
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

    echo "$BM_LINE" | awk -v rfn=$RFN -v ds=$DEST_SYS 'BEGIN{FS="\t";OFS="\t"}{print $1,$2,$3,$4,$5,rfn,$7,$8,$9,$10,ds}' >> $OUT_BM

done < $UUIDS

>&2 echo Written to $OUT_BM

>&2 echo Merging with $BAMMAP_DEST 
head -n 1 $OUT_BM > $OUT_BM_MERGED
cat $BAMMAP_DEST $OUT_BM | grep -v "^#" | sort >> $OUT_BM_MERGED

>&2 echo Written to new merged BamMap $OUT_BM_MERGED
>&2 echo Examine closely and copy to repository
