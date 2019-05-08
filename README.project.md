Test katmai BamMap for
1) bad links
2) duplicated data


### Errors in katmai BamMap file.

/diskmnt/Projects/cptac_scratch/CPTAC3.workflow/CPTAC3.catalog/katmai.BamMap.dat
    commit 6be1f77038b770257c350c4049266454edc254fc

Can get statistics on status:
```
$ bash 1_test_BamMap.sh -v | cut -f 3 | sort | uniq -c
      8 DUPLICATE_OK
   1018 NO_FILE
   3835 OK
      1 status
```

### how to fix

BAD: /diskmnt/Projects/cptac_downloads_1/

Replace with: /diskmnt/Projects/cptac3_primary_1/



