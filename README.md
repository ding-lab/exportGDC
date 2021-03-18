BamMap utilities including
* Utilities / workflows for copying GDC data (CPTAC3 BAM, FASTQ files) from one 
system to another.  
* Update BamMap information.  

Work here began as ad hoc analyses / fixes implemented as independent workflows, and those
workflows are reteained more or less independently in workflows in their own directories.
Motivation is to keep all such workflows and utilities in one place to make life easier and
create common codebase.  



## What is a BamMap file
Note that we track all CPTAC3 data downloaded to our systems in BamMap files; in particular,
on MGI, we expect that this file always reflect data found on disk:
`/gscmnt/gc2521/dinglab/mwyczalk/projects.CPTAC3/CPTAC3.catalog/BamMap/MGI.BamMap.dat`

For this reason this file needs to be updated when data are added and deleted.

# Workflows - globus copy and delete

This documetation is updated for the specific task of copying data via globus from storage1 to MGI,
then deleting it once processing is complete, updating the BamMap at each step

## Getting started
First clone a new repository from the master `exportGDC` repository to get scripts as well as templates
of analyses:
```
git clone https://github.com/ding-lab/exportGDC.git --recurse-submodules 20210317.globus_storage
```
Where `20210317.globus_storage` is the name of the respository which will be created.  Do all your work there.

## Copy via globus
Details here:
D_globus_from_storage1/README.md

## Delete data on MGI
E_remove_data/README.md



# Workflows - historic

## Workflow directory structure

Workflows in A_XXX, B_XXX, with each of these serving as ready-working example
workflows which are developed in place for different projects.  Common codebase in ./src, etc.
May need to tighten up strucutre in future

## A Update sample names
./A_update_sample_names from shiso:/Users/mwyczalk/Projects/CPTAC3/CPTAC3.Cases/20201109.update_sample_names

## B Upload to MGI
Transfer data between systems

## C FSCK
Contents of fsck branch moved to own workflow.  May want to merge code from here to common
codebase

/diskmnt/Projects/cptac_scratch/CPTAC3.workflow/export/20190507-BamMap-Edits

## `D_globus_from_storage1`

Copy data based on UUID list from storage1 to MGI using globus
Update BamMap

## `E_remove_data`
Remove data based on UUID list from MGI
Update BamMap

