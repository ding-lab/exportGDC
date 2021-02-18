source globus_copy.config.sh

# Format for batch file:
# --recursive 0149a1bf-30e0-41c3-994d-70bb82818c4d 0149a1bf-30e0-41c3-994d-70bb82818c4d

>&2 echo Reading $UUIDS
>&2 echo Writing to $BATCH_FILE

paste -d ' ' $UUIDS $UUIDS | sed 's/^/--recursive /' > $BATCH_FILE

