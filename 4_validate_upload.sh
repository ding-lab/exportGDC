BAMMAP="dat/katmai.LUAD-UCEC.hg38.WXS.BamMap.dat"
SR="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/CPTAC3.hg38.b2.HAR.dat"

cut -f 10 $BAMMAP | grep -v UUID | bash ../export_utils/upload_to_MGI.sh -V -B $BAMMAP -S $SR $@ -
