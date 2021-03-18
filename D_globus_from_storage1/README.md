# Previous work

See `doc/README.globus_testing.md` (originally /gscuser/mwyczalk/projects/Globus/README.md) for details of preliminary work



# Instructions

Assuming copying from storage1 to MGI

## Configuration

Edit `globus_copy.config.sh` to define the source and destination systems and other details.  

In a globus transfer it is helpful to think of three independent systems:
* `GLOBUS_SYS` - this is the system where execution of these scripts is taking place
* `SOURCE_SYS` - source of globus transfer
* `DEST_SYS`   - target of globus transfer

Configuration of paths and other parameters in `globus_copy.config.sh` is with respect to these

Additional parameters to define:
* Update `LABEL` to something identifying this batch.  This will be associated with globus download

## Get UUID

List of data to transfer is defined in by the file `dat/UUID_to_copy.dat`.

### Example

Make a UUID file from two BamMap files with,
```
cut -f 10 dat/GBM_cases_toCopy_fromStorage1.tsv dat/CCRCC_cases_toCopy_fromStorage1.tsv | grep -v UUID | sort > dat/UUID_to_copy.dat
```

## Start globus-cli docker image
Using utilities provided in [globus-cli](https://docs.globus.org/cli).  This is in a
docker image that we start to make this available.

Start the docker image with,
`bash 00_start_globus_cli_docker.sh`


## Making a batch file

A batch file is needed for input into the copy process to define the data copied and is generated with,
```
bash 05_make_UUID_batch.sh
```

Format for batch file input:
```
--recursive 0149a1bf-30e0-41c3-994d-70bb82818c4d 0149a1bf-30e0-41c3-994d-70bb82818c4d
...
```

## get download statistics

Run the script,
```
bash 10_summarize_download.sh
```
to get a summary of download statistics like,
```
Total required disk space WGS: 19.0737 Tb in 209 files
                          WXS: 0 Tb in 0 files
                      RNA-Seq: 0 Tb in 0 files
                    miRNA-Seq: 0 Tb in 0 files
            Methylation Array: 0 Tb in 0 files
          Targeted Sequencing: 0 Tb in 0 files
                        TOTAL: 19.0737 Tb (19531.5 Gb) in 209 files
```
Suggest pasting these details into the README.project.md file for future reference

Importantly, confirm that the destination volume has enough space.  For instance, with
the destination directory defined in `globus_copy.config.sh` as,
    DEST_DIR="/gscmnt/gc2619/dinglab_cptac3/GDC_import/data/
we can verify this as,
```
$ df -h     $DEST_DIR
Filesystem      Size  Used Avail Use% Mounted on
aggr3            85T   61T   25T  72% /gscmnt/gc2619
```

## Start the download

Once everything looks good, test globus with a dry run like,
```
bash 20_start_globus_transfer.sh --dry-run
```

Once this checks out start the download as,
```
bash 20_start_globus_transfer.sh 
```

If you get a message like below you will need to activate the connection.
```
The endpoint could not be auto-activated and must be activated before it can be used.
...
```


### Activation

In general, both endpoints (Storage1 and Storage0) need to be activated.  The script 
20_start_globus_transfer.sh will provide instructions on how to authenticate; currently,
using web activation for both.  This requires something like the following string to be pasted
to the command line,
```
    globus endpoint activate --web e66a20e4-aaf1-11e8-970a-0a6d4e044368
```

which in turn provides a URL which is pasted into  browser to authenticate.
Note that Storage0 authentication requires the MGI username / password, which
is in general different from the WUSTL Key used for Storage1 authentication.

### Starting download

Once authentication is complete, a successful start looks like,
```
$ bash 20_start_globus_transfer.sh
Message: The transfer has been accepted and a task has been created and queued for execution
Task ID: da8b5426-7bb6-11eb-80c0-bd6c7ce89613
```

Once download is submitted you can exit from the session

### Documenting download

For CPATC3 year 3 work, tracking copying and deleting of data in the [CPTAC3 Y3
Pipeline
Management](https://docs.google.com/spreadsheets/d/1fbBZRPgyM21E1Eq1Se4qzHRWPII34CIUWUutuKRRoCs/edit#gid=483881005)
spreadsheet.  If this is part of the CPTAC3 dataset please track of data movement there for auditing and error tracking

### Tracking download

You can track activity from the [globus web app](https://app.globus.org/activity) or using the command line
utility

## Updating BamMap

Do a `git pull origin master` of CPTAC3 catalog in directory defined by CATALOGD in globus_copy.config.sh
to make sure have the latest version

Then run
```
bash 30_make_BamMap.sh
```
to verify all data downloaded and to create the files
* dat/MGI.BamMap.globus_copy.dat - has just the newly downloaded data
* dat/MGI.BamMap.merged.dat - has new global BamMap file, based on merge with global BamMap 

### Update global BamMap

Inspect and copy new BamMap with,
```
vimdiff dat/MGI.BamMap.merged.dat /gscuser/mwyczalk/projects/CPTAC3/CPTAC3.catalog/BamMap/MGI.BamMap.dat
cp dat/MGI.BamMap.merged.dat /gscuser/mwyczalk/projects/CPTAC3/CPTAC3.catalog/BamMap/MGI.BamMap.dat
```

Finally, perform `git add` and `git commit` on the new global BamMap 
