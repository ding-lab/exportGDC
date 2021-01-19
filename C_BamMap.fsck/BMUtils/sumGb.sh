# Sums numbers from STDIN and print out size in Gb

awk '{sum+=$1} END {print sum / 1024 / 1024 / 1024 " Gb"}' -
