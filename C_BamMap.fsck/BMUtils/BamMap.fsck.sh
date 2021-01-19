# Test and fix BamMap-defined data.  Prints list of UUIDs and their status 
#
# Usage: BamMap.fsck.sh [options] BAMMAP
#
# Writes following information to STDOUT:
#   sample_name     UUID    status      data_path
#
# -d: dry run.  Perform all existence tests 
# -1: Stop after one line of BamMap
# -v: verbose.  Print output if no error

# If UUID is '-', read UUIDs from STDIN
# Header is written

while getopts ":dv1" opt; do
  case $opt in
    d) 
      DRYRUN=1      # doesn't do anything
      ;;
    1) 
      ONLY_ONE=1 
      ;;
    v) 
      VERBOSE=1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

if [ "$#" -ne 1 ]; then
    >&2 echo Error: Wrong number of arguments
    exit
fi
BAMMAP=$1

if [ -z $BAMMAP ]; then
    >&2 echo Error: BamMap not defined \[-B\]
    exit 1
fi
if [ ! -e $BAMMAP ]; then
    >&2 echo Error: BamMap does not exist: $BAMMAP
    exit 1
fi

if [ "$#" -lt 1 ]; then
    >&2 echo Error: Pass at least one UUID
    exit
fi

# For each UUID, obtain path from BamMap and write the following:
#   sample_name     UUID    status      data_path
# If no match of UUID in BamMap, status is UNKNOWN
# Otherwise, evaluate status of path, which is one of the following:
# * OK          - file exists and is regular file, not a link
# * NO_FILE     - file does not exist
# * ZERO_SIZE
# * GOOD_LINK
# * BAD_LINK
# If there is more than one match, prepend "DUPLICATE_" to status
#
function checkUUID {
    SN=$1
    UUID=$2
    UUID=$3

    COUNT=$(grep -c "$UUID" "$BAMMAP")
    if [ $COUNT != "1" ]; then
        PREFIX="DUPLICATE_"
    fi
    
    if [ -h $DATAFN ]; then   # is symlink
        if [ -e $DATAFN ]; then # is good symlink
            STATUS="GOOD_LINK"
        else
            STATUS="BAD_LINK"
        fi
    elif [ ! -e $DATAFN ]; then
        STATUS="NO_FILE"
    elif [ ! -s $DATAFN ]; then
        STATUS="ZERO_SIZE"
    else
        STATUS="OK"
    fi

    STATUS="${PREFIX}${STATUS}"
    if [ $STATUS == "OK" ] && [ ! $VERBOSE ]; then
        return      # Return quietly and print nothing
    fi

    printf "$SN\t$UUID\t$STATUS\t$DATAFN\n"
}

HEADER=$( printf "# sample_name\tUUID\tstatus\tdata_path\n" )
echo "$HEADER"

# Iterate over BamMap, and evaluate each line 
while read BM; do
    # Skip comments and header
    [[ $BM = \#* ]] && continue

    SN=$(echo "$BM" | cut -f 1)
    DATAFN=$(echo "$BM" | cut -f 6)
    UUID=$(echo "$BM" | cut -f 10)

    RESULT=$(checkUUID $SN "$DATAFN" $UUID )
    if [ ! -z "$RESULT" ]; then
        echo "$RESULT"
    fi
    if [ "$ONLY_ONE" ]; then
        >&2 echo Quitting after one
        break
    fi

done < $BAMMAP

