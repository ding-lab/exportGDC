# Previous work

See `doc/README.globus_testing.md` (originally /gscuser/mwyczalk/projects/Globus/README.md) for details of preliminary work

# Making a batch file

A batch file is needed for input into the copy process.  This consists of a modified UUID list.

Format for batch file input:
```
--recursive 0149a1bf-30e0-41c3-994d-70bb82818c4d 0149a1bf-30e0-41c3-994d-70bb82818c4d
```

# Configuration

Need to edit configuration file `globus_copy.config.sh`

In a globus transfer it is helpful to think of three independent systems:
* `GLOBUS_SYS` - this is the system where execution of these scripts is taking place
* `SOURCE_SYS` - source of globus transfer
* `DEST_SYS`   - target of globus transfer

Configuration of paths and other parameters in `globus_copy.config.sh` is with respect to these

## Activation

In general, both endpoints (Storage1 and Storage0) need to be activated.  The script 
20_start_globus_transfer.sh will provide instructions on how to authenticate; currently,
using web activation for both.  This requires something like the following string to be pasted
to the command line,
    globus endpoint activate --web e66a20e4-aaf1-11e8-970a-0a6d4e044368

which in turn provides a URL which can be used on any browser to authenticate.  Note that Storage0
authentication requires the MGI username / password, which is in general different from the WUSTL Key used
for Storage1 authentication.

# Starting download

Once authentication is complete, a successful start looks like,
```
$ bash 20_start_globus_transfer.sh
Message: The transfer has been accepted and a task has been created and queued for execution
Task ID: da8b5426-7bb6-11eb-80c0-bd6c7ce89613
```
