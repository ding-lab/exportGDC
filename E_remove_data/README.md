Removing data by Clara.  UUID list:
/storage1/fs1/dinglab/Active/Projects/cliu/GBM_confirmatory/remove_from_bammap/20220427_GBM_673/UUID.txt

# Instructions
* Review `10_remove_data.sh` to make sure system is properly defined
* Run `bash 10_remove_data.sh -d`, which will perform a "dry run".  Confirm
  it executes and paths are correct
* Run `bash 10_remove_data.sh` to really remove the data
  * Be careful!  This will delete a lot of data very quickly.  Don't do this without
    testing with dryrun first.
* Deletion process generates a new global catalog file for the MGI system here: 
    `dat/MGI.BamMap.post-delete.dat`
  * To maintain integrity of data tracking this updated file is copied to the
    master MGI directory as,
    `cp MGI.BamMap.post-delete.dat ~/projects/CPTAC3/CPTAC3.catalog/BamMap/MGI.BamMap.dat`
  * This new version is committed to the git repository there and pushed to GitHub

Get cumulative size with,
$ grep -f /storage1/fs1/dinglab/Active/Projects/cliu/GBM_confirmatory/remove_from_bammap/20220427_GBM_673/UUID.txt ~/Projects/CPTAC3/CPTAC3.catalog/BamMap/storage1.BamMap.dat | cut -f 7 | bash ../BMUtils/sumGb.sh
