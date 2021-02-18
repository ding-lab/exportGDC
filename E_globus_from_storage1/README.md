Format for batch file input:
```
--recursive 0149a1bf-30e0-41c3-994d-70bb82818c4d 0149a1bf-30e0-41c3-994d-70bb82818c4d
```

## Configuration

In a globus transfer it is helpful to think of three independent systems:
* GLOBUS_SYS - this is the system where execution of these scripts is taking place
* SOURCE_SYS - source of globus transfer
* DEST_SYS   - target of globus transfer

Configuration of paths and other parameters in globus_copy.config.sh is with respect to these

## Activation

May need to activate with something like,
    globus endpoint activate --web e66a20e4-aaf1-11e8-970a-0a6d4e044368

if 20_start_globus_transfer.sh returns an activation error
