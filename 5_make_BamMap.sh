# Create a BamMap for remote system
# This is done by replacing the path and system columns 

LOCAL_BAMMAP="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/denali.BamMap.dat"  

# local path for destination system BamMap
DESTINATION_BAMMAP="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/katmai.BamMap.dat"
DESTINATION_SYSTEM="katmai"

UUIDS="dat/UUIDs_to_download.dat"
OUT_BM="dat/${DESTINATION_SYSTEM}.BamMap.export.dat"
OUT_BM_MERGED="dat/${DESTINATION_SYSTEM}.BamMap.merged.dat"

# Path on remote / destination system
STAGE_ROOT_REMOTE="/diskmnt/Projects/cptac_downloads_1"
REMOTED="$STAGE_ROOT_REMOTE/GDC_import/data" 

# Write header
grep "^#" $LOCAL_BAMMAP | head -n 1 > $OUT_BM

# for each UUID, obtain local BamMap entry.  To write remote BamMap, replace the filename and system columns
# filename is obtained from the filename and parent directory of the local path, with remote path prepended
# Note that an alternate approach is on MGI:/gscuser/mwyczalk/projects/CPTAC3/import/examine_import/LUAD-UCEC.hg38.WXS
# Where the BamMap is created on the destination end using importGDC/make_bam_map.sh code
# Advantage here is that it is done all on source end, but will need to confirm that the BamMap is correct on remote regardless

while read UUID; do
    # Skip comments and header
    [[ $UUID = \#* ]] && continue
    >&2 echo $UUID

    BM_LINE=$(grep $UUID $LOCAL_BAMMAP)
    LFN=$(echo "$BM_LINE" | cut -f 6)
    >&2 echo Local FN = $LFN
    FN="$(basename $LFN)"
    RFN="$REMOTED/$UUID/$FN"
    >&2 echo Remote FN = $RFN

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

    echo "$BM_LINE" | awk -v rfn=$RFN -v ds=$DESTINATION_SYSTEM 'BEGIN{FS="\t";OFS="\t"}{print $1,$2,$3,$4,$5,rfn,$7,$8,$9,$10,ds}' >> $OUT_BM

done < $UUIDS

>&2 echo Written to $OUT_BM

>&2 echo Merging with $DESTINATION_BAMMAP
head -n 1 $OUT_BM > $OUT_BM_MERGED
cat $DESTINATION_BAMMAP $OUT_BM | grep -v "^#" | sort >> $OUT_BM_MERGED

>&2 echo Written to new merged BamMap $OUT_BM_MERGED
>&2 echo Examine closely and copy to remote system
