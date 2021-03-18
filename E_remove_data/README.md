Remove data based on UUID.  In this case, removing data which was copied to MGI
in ../D_globus_from_storage1

List of UUIDs to delete is defined in `10_remove_data.sh` as `UUID_DELETE`; currently
it points to the list generated for copying,
`../D_globus_from_storage1/dat/UUID_to_copy.dat`
The value of `UUID_DELETE` can be modified for testing or to delete other data.

Note that we track all CPTAC3 data downloaded to our systems in BamMap files; in particular,
on MGI, we expect that this file always reflect data found on disk:
`/gscmnt/gc2521/dinglab/mwyczalk/projects.CPTAC3/CPTAC3.catalog/BamMap/MGI.BamMap.dat`

For this reason this file needs to be updated when data are added and deleted.

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


