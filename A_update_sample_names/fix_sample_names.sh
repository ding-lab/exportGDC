# Usage: fix_sample_names.sh BamMap Catalog

BM=$1
CATALOG=$2

if [ ! -e $BM ]; then
    >&2 echo ERROR: $BM does not exist
    exit 1
fi
if [ ! -e $CATALOG ]; then
    >&2 echo ERROR: $CATALOG does not exist
    exit 1
fi

# BamMap columns
#     1	# sample_name
#     2	case
#     3	disease
#     4	experimental_strategy
#     5	sample_type
#     6	data_path
#     7	filesize
#     8	data_format
#     9	reference
#    10	UUID
#    11	system

# Catalog columns
#      1	# sample_name
#      2	case
#      3	disease
#      4	experimental_strategy
#      5	short_sample_type
#      6	aliquot
#      7	filename
#      8	filesize
#      9	data_format
#     10	result_type
#     11	UUID
#     12	MD5
#     13	reference
#     14	sample_type

while read L; do
    # Skip comments 
    if [[ $L = \#* ]] ; then
        printf "$L\n"
        continue
    fi

    BM_SN=$(echo "$L" | cut -f 1)
    BM_POST=$(echo "$L" | cut -f 2- )
    UUID=$(echo "$L" | cut -f 10)

    CAT_SN=$( fgrep $UUID $CATALOG | cut -f 1)

    if [ "$BM_SN" != "$CAT_SN" ]; then
        >&2 echo $UUID: BamMap = $BM_SN  Catalog = $CAT_SN
    fi
    printf "$CAT_SN\t$BM_POST\n"

done < $BM

