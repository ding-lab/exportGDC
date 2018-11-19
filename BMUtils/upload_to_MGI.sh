# Copy CPTAC3 data to remote host

# file to upload can either be constructed from LOCALD and UUID, or else obtained from BamMap
#
# Usage: UUIDs.dat > upload_to_MGI.sh -
#    or: nohup bash -c "tail -n +2 dat/UUID.0918-Sync.dat | bash upload_to_MGI.sh -" &> log1.dat &

# Options
# -S SR_FILE: path to SR data file.  If provided, will test whether uploaded data exists and has expected size
# -B BAMMAP: Path to BamMap.  If not defined, path to data will be constructed from UUID and LOCALD
# -f : Force upload of data which appears incomplete (unexpected size)
# -d : Dry run - skip actual upload
# -1 : Stop after one UUID processed
# -V : Validate - print remote file diagnostics but do not upload
# -v : verbose

# This should be moved to a config file
LOCALD="/diskmnt/Projects/cptac/GDC_import/data"
REMOTED="/gscmnt/gc2619/dinglab_cptac3/GDC_import/data"
HOST="mwyczalk@virtual-workstation3.gsc.wustl.edu"

# http://wiki.bash-hackers.org/howto/getopts_tutorial
while getopts ":dv1S:B:fV" opt; do
  case $opt in
    d)  
      >&2 echo "Dry run"
      DRYRUN=1
      ;;
    v)  
      VERBOSE=1
      ;;
    V)  
      VALIDATE=1
      ;;
    1)  
      >&2 echo "Stop after one"
      STOPAFTERONE=1
      ;;
    S) 
      SRFN=$OPTARG
      ;;
    B) 
      BAMMAP=$OPTARG
      ;;
    f)  
      >&2 echo "Forcing upload of incomplete data"
      FORCE=1
      ;;
    \?)
      >&2 echo "Invalid option: -$OPTARG"
      exit 1
      ;;
    :)
      >&2 echo "Option -$OPTARG requires an argument."
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

if [ "$#" -ne 1 ]; then
    >&2 echo Error: Wrong number of arguments
    exit 1
fi

UUIDS=$1

# SR file is optional, but if defined, it must exist.  Same logic for BamMap
if [[ -z $SRFN ]]; then
    >&2 echo NOTE: SR file not defined.  Will not check if file being uploaded exists remotely
elif [[ ! -z $SRFN && ! -f $SRFN ]]; then
    >&2 echo ERROR: SR file does not exist: $SRFN 
    exit 1
fi
if [[ ! -z $BAMMAP && ! -f $BAMMAP ]]; then
    >&2 echo ERROR: BAMMAP file does not exist: $BAMMAP 
    exit 1
fi


# https://zaiste.net/a_few_ways_to_execute_commands_remotely_using_ssh/
# Test the existence and optionally size of remote data file
# Usage: test_dest UUID FN EXPECTED_SIZE
# Returns 0 if file does not exist remotely, 
#         1 if it does and has expected length
#         2 if it does and has incorrect length 
#
# If expected size is unknown, pass as 0; only 0 or 1 will be returned
# 
# From /home/mwyczalk_test/Projects/CPTAC3/import/import.CPTAC3.LUAD.b5/importGDC/make_bam_map.sh
function test_dest {
    UUID=$1 
    FN=$2  # filename
    DS=$3  # expected file size
    
    # Test existence of output file and index file
    FNF=$(echo "$REMOTED/$UUID/$FN" | tr -s '/')  # append full path to data file, normalize path separators

# https://stackoverflow.com/questions/12845206/check-if-file-exists-on-remote-host-with-ssh
    if ! ssh -q $HOST "[[ -f $FNF ]]" ; then
        if [[ $VERBOSE ]]; then
            >&2 echo NOTE: $FNF does not exist
        fi
        echo 0
        return
    elif [[ $VERBSOSE ]]; then
        >&2 echo $FNF exists
    fi
    if [[ $DS == 0 ]]; then
        if [[ $VERBOSE ]]; then
            >&2 echo NOTE: $FNF exists, not checking size
        fi
        echo 1
        return
    fi

    # Test actual filesize at remote location vs. size expected from SR file
    # stat has different usage on Mac and Linux.  Try both, ignore errors
    # stat -f%z - works on Mac
    # stat -c%s - works on linux
    BMSIZE=$(ssh $HOST "stat -f%z $FNF 2>/dev/null || stat -c%s $FNF 2>/dev/null " )
    if [ "$BMSIZE" != "$DS" ]; then
        if [[ $VERBOSE ]]; then
            >&2 echo NOTE: $FNF size \($BMSIZE\) differs from expected \($DS\)
        fi
        echo 2
    else
        if [[ $VERBOSE ]]; then
            >&2 echo EXISTS: $FNF \($BMSIZE\) 
        fi
        echo 1
    fi
}


function copy_to_remote {
	UUID=$1
    DATAD=$2

	if [ ! -d $DATAD ]; then
		>&2 echo ERROR: $DATAD does not exist.  Skipping.
		return
	fi


    # scp vs. rsync
    # scp is faster but rsync is much better at evaluating whether destination files exist on remote server
    # We also need to exclude "logs" directory, since copying it gives permission errors; this is harder with scp
    # performance issues with rsync: https://gist.github.com/KartikTalwar/4393116
    # 
	CMD="scp -r $DATAD $HOST:$REMOTED"
    #CMD="rsync -aHAXxv --numeric-ids --delete --progress --exclude='logs' -e 'ssh -T -o Compression=no -x' $DATAD $HOST:$REMOTED"

    if [[ $VERBOSE ]]; then
        >&2 echo Running command: "$CMD"
    fi

	if [ -z $DRYRUN ]; then
        # eval helps deal with quotes correctly  https://stackoverflow.com/questions/11079342/execute-command-containing-quotes-from-shell-variable
        eval $CMD  
	else
		>&2 echo Skipping dry run.  Command:
		>&2 echo $CMD
	fi

	rc=$?
	if [[ $rc != 0 ]]; then
		>&2 echo ERROR copying $DATAD to $HOST:$REMOTED
		>&2 echo $rc: $!
	else
        if [[ $VERBOSE ]]; then
            >&2 echo Success 
            >&2 echo 
        fi
    fi
}

# this allows us to get UUIDs in one of two ways:
# 1: start_step.sh ... UUID1 UUID2 UUID3
# 2: cat UUIDS.dat | start_step.sh ... -
if [ $1 == "-" ]; then
    UUIDS=$(cat - )
else
    UUIDS="$@"
fi

VAR=( $UUIDS )
N_UUIDS=${#VAR[@]}

UUIDS_SEEN=0


# Loop over all remaining arguments
for UUID in $UUIDS
do

    # Skip comments
    [[ $UUID = \#* ]] && continue 

    UUIDS_SEEN=$(($UUIDS_SEEN + 1))
    if [[ $VERBOSE ]]; then
        >&2 echo Processing $UUIDS_SEEN / $N_UUIDS [ $(date) ]: $UUID
    fi

    SKIP=0
    # Test for remote file existence and size, but only if SR filename exists (since we need this info
    # for filename and file size)
    if [ ! -z $SRFN ]; then
        SR=$(grep $UUID $SRFN)  # assuming only one value returned
        if [ -z "$SR" ]; then
            >&2 echo UUID $UUID not found in $SRFN
            >&2 echo Quitting.
            exit 1
        fi
        FN=$(echo "$SR" | cut -f 7)
        DS=$(echo "$SR" | cut -f 8)

        CMD="test_dest $UUID $FN $DS"
        RC=$($CMD)

        # Validate mode is designed to give just a terse summary of remote status without any uploads
        if [[ $VALIDATE ]]; then
            if [[ $RC == 0 ]]; then
                >&2 printf "$UUID\tAbsent\n"
            elif [[ $RC == 1 ]]; then
                >&2 printf "$UUID\tComplete\n"
            elif [[ $RC == 2 ]]; then
                >&2 printf "$UUID\tIncomplete\n"
            else
                >&2 printf "$UUID - illegal return code\n"
                exit 1
            fi
            SKIP=1
        else 
            if [[ $RC == 0 ]]; then
                >&2 echo "$UUID does not exist remotely.  Uploading."
            elif [[ $RC == 1 ]]; then
                >&2 echo "$UUID exists remotely and appears complete.  Not uploading."
                SKIP=1
            else
                if [[ ! -z $FORCE ]]; then
                    >&2 echo "$UUID exists remotely but appears incomplete.  Uploading."
                else
                    >&2 echo "$UUID exists remotely but appears incomplete.  Not uploading."
                    SKIP=1
                fi                      
            fi
        fi
    fi

    if [[ $SKIP == 0 ]]; then
        # We will upload entire directory where data exists, to catch secondary files like .bai and .flagstat
        # We can obtain DATAD from either $LOCALD (local storate base directory) and UUID, or from the BamMap file
        if [ -z $BAMMAP ]; then
            DATAD=$LOCALD/$UUID
        else
            DATAD=$(dirname $(grep $UUID $BAMMAP | cut -f 6 ))
        fi
        copy_to_remote $UUID $DATAD
    fi

    if [ ! -z $STOPAFTERONE ]; then
        >&2 echo Stopping after processing one
        exit 0
    fi            
done
