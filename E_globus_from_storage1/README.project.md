Development of transfer using globus from storage1 to storage0 (MGI)

See notes here:
    /gscuser/mwyczalk/projects/Globus/README.md

Files to transfer based on list provided by Nadya, 
    EC_cases_toCopy_fromStorage1.tsv
These will be copied to 
    /gscmnt/gc2619/dinglab_cptac3

Format for batch file input:
```
--recursive 0149a1bf-30e0-41c3-994d-70bb82818c4d 0149a1bf-30e0-41c3-994d-70bb82818c4d
```


Total required disk space WGS: 9.2958 Tb in 95 files
                          WXS: 0 Tb in 0 files
                      RNA-Seq: 0 Tb in 0 files
                    miRNA-Seq: 0 Tb in 0 files
            Methylation Array: 0 Tb in 0 files
          Targeted Sequencing: 0 Tb in 0 files
                        TOTAL: 9.2958 Tb in 95 files

Ran with just one dataset first, then with remaining 94.  First one succeeded, remaining one is going

e6733cf4-6bf8-11eb-8289-0275e0cda761 | SUCCEEDED | TRANSFER | Wash U RIS storage1 dtn1                                         | MGI storage0 data transfer node | Storage1 to MGI - 20210210a
2024ac52-6bfa-11eb-8c3d-0eb1aa8d4337 | ACTIVE    | TRANSFER | Wash U RIS storage1 dtn1                                         | MGI storage0 data transfer node | Storage1 to MGI - 20210210 all remaining

## Configuration

In a globus transfer it is helpful to think of three independent systems:
* GLOBUS_SYS - this is the system where execution of these scripts is taking place
* SOURCE_SYS - source of globus transfer
* DEST_SYS   - target of globus transfer

Configuration of paths and other parameters in globus_copy.config.sh is with respect to these
