Notes and recipes for using Globus to transfer data between MGI and compute1

# Getting started with globus
## Background reading

[How to use Globus to transfer data from Storage0 to Storage1](https://confluence.ris.wustl.edu/display/ITKB/How+to+use+Globus+to+transfer+data+from+Storage0+to+Storage1)

[Globus CLI Examples](https://docs.globus.org/cli/examples/)


## Installing Globus

WU RIS has a description of how to use globus CLI on compute1, and provide a Dockerfile:
    https://docs.ris.wustl.edu/doc/compute/recipes/tools/globus-cli-dockerimage.html
Have not currently built this, though may in the future.

For now, using a docker image found online: https://hub.docker.com/r/liambindle/globus-cli
    bash start_docker.sh -M MGI -I liambindle/globus-cli
in directory /gscuser/mwyczalk/projects/WUDocker

## Running globus-cli

Using [Quick Start](https://docs.globus.org/cli/quickstart/)

## Login
```
globus login
```

## Endpoints of interest

Storage1 endpoint have been using for transferint data to: "Wash U RIS storage1 dtn1"
Path: /storage1/fs1/m.wyczalkowski/Active/Primary/HTAN.backup/MGI-globus/

globus endpoint search "Wash U RIS storage1 dtn1"

ID                                   | Owner              | Display Name
------------------------------------ | ------------------ | ------------------------
01f0ac4c-9570-11ea-b3c4-0ae144191ee3 | wustl@globusid.org | Wash U RIS storage1 dtn1
7e5cf228-8b33-11ea-bf85-0e6cccbb0103 | wustl@globusid.org | Wash U RIS storage1 dtn2

globus endpoint search "MGI storage0"
ID                                   | Owner              | Display Name
------------------------------------ | ------------------ | -------------------------------
e66a20e4-aaf1-11e8-970a-0a6d4e044368 | wustl@globusid.org | MGI storage0 data transfer node

### Remembering these
S0=e66a20e4-aaf1-11e8-970a-0a6d4e044368
S1=01f0ac4c-9570-11ea-b3c4-0ae144191ee3

## MGI storage0 endpoint

Using online file manager, need to authenticate with MGI username (mwyczalk, <MGI password>) in
order to be able to access "MGI storage0 data transfer node"

Path where we'll be copying data to: /gscmnt/gc2619/dinglab_cptac3/GDC_import/data/

### Viewing MGI data
```
globus ls $S0:/gscmnt/gc2619/dinglab_cptac3/GDC_import/data/
```

## globus transfer
[globus transfer reference](https://docs.globus.org/cli/reference/transfer/)

NOTE: see companion project on MGI here: 
    /gscmnt/gc2521/dinglab/mwyczalk/projects.CPTAC3/export/20210210.globus_storage1/E_globus_from_storage1

SRC_DIR="/storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/CPTAC3-GDC/GDC_import/data/"
DEST_DIR="/gscmnt/gc2619/dinglab_cptac3/GDC_import/data/"
UUID="path_to_uuid"

globus transfer $S1:/share/godata/ $S0:~/ --batch --label "Storage1 to MGI - 20210210" < $UUID
