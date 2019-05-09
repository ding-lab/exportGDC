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

BAD: 
  /diskmnt/Projects/cptac_downloads_1
  /diskmnt/Projects/cptac_downloads_2
  /diskmnt/Projects/cptac_downloads_3
  /diskmnt/Projects/cptac_downloads_5
Replace with: /diskmnt/Projects/cptac3_primary_1/

### Duplicates

There are a couple errors left.  The following UUIDs have duplicates:
    0b2fad41-5d67-46bc-b1ee-97f4d62a3c6c
    406d591c-de8b-4d87-a6fc-a3c7072a92c4
    a052b208-245c-4170-85a4-8a6dbd6f62d3
    c99c5a0e-9d28-4f34-b894-f2dc99fafad6

Note that these are all provisional:
    C3L-00935.RNA-Seq.A.hg38    C3L-00935   UCEC    RNA-Seq tissue_normal   /diskmnt/Projects/cptac_downloads_7/GDC_import/data/0b2fad41-5d67-46bc-b1ee-97f4d62a3c6c/3c722dbb-2e8b-46dc-92da-99bd991568e0.rna_seq.genomic.gdc_realn.bam 9528489775  BAM hg38    0b2fad41-5d67-46bc-b1ee-97f4d62a3c6c    katmai
    C3L-00935.RNA-Seq.prov.CPT0027220013    C3L-00935   UCEC    RNA-Seq CPT0027220013   /diskmnt/Projects/cptac_downloads_7/GDC_import/data/406d591c-de8b-4d87-a6fc-a3c7072a92c4/35c7131c-209a-4edf-8d46-520ad1dbee9a.rna_seq.genomic.gdc_realn.bam 8067316137  BAM hg38    406d591c-de8b-4d87-a6fc-a3c7072a92c4    katmai
    C3L-00935.RNA-Seq.prov.CPT0027230006    C3L-00935   UCEC    RNA-Seq CPT0027230006   /diskmnt/Projects/cptac_downloads_7/GDC_import/data/0b2fad41-5d67-46bc-b1ee-97f4d62a3c6c/3c722dbb-2e8b-46dc-92da-99bd991568e0.rna_seq.genomic.gdc_realn.bam 9528489775  BAM hg38    0b2fad41-5d67-46bc-b1ee-97f4d62a3c6c    katmai
    C3L-00935.RNA-Seq.T.hg38    C3L-00935   UCEC    RNA-Seq tumor   /diskmnt/Projects/cptac_downloads_7/GDC_import/data/406d591c-de8b-4d87-a6fc-a3c7072a92c4/35c7131c-209a-4edf-8d46-520ad1dbee9a.rna_seq.genomic.gdc_realn.bam 8067316137  BAM hg38    406d591c-de8b-4d87-a6fc-a3c7072a92c4    katmai
    C3L-01277.RNA-Seq.A.hg38    C3L-01277   UCEC    RNA-Seq tissue_normal   /diskmnt/Projects/cptac_downloads_7/GDC_import/data/a052b208-245c-4170-85a4-8a6dbd6f62d3/4c456c2b-3ee3-4298-89f1-e14f755dca07.rna_seq.genomic.gdc_realn.bam 8813323386  BAM hg38    a052b208-245c-4170-85a4-8a6dbd6f62d3    katmai
    C3L-01277.RNA-Seq.prov.CPT0093170006    C3L-01277   UCEC    RNA-Seq CPT0093170006   /diskmnt/Projects/cptac_downloads_7/GDC_import/data/c99c5a0e-9d28-4f34-b894-f2dc99fafad6/8ba80801-bbc2-4de0-afa7-ad1c78a47692.rna_seq.genomic.gdc_realn.bam 11022451314 BAM hg38    c99c5a0e-9d28-4f34-b894-f2dc99fafad6    katmai
    C3L-01277.RNA-Seq.prov.CPT0093180006    C3L-01277   UCEC    RNA-Seq CPT0093180006   /diskmnt/Projects/cptac_downloads_7/GDC_import/data/a052b208-245c-4170-85a4-8a6dbd6f62d3/4c456c2b-3ee3-4298-89f1-e14f755dca07.rna_seq.genomic.gdc_realn.bam 8813323386  BAM hg38    a052b208-245c-4170-85a4-8a6dbd6f62d3    katmai
    C3L-01277.RNA-Seq.T.hg38    C3L-01277   UCEC    RNA-Seq tumor   /diskmnt/Projects/cptac_downloads_7/GDC_import/data/c99c5a0e-9d28-4f34-b894-f2dc99fafad6/8ba80801-bbc2-4de0-afa7-ad1c78a47692.rna_seq.genomic.gdc_realn.bam 11022451314 BAM hg38    c99c5a0e-9d28-4f34-b894-f2dc99fafad6    katmai

### Deprecated data

Also, need to remove deprecated data from katmai.  This can be identified as UUIDs which are in BamMap but not in AR file


