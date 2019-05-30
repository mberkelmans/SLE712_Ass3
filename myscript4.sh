 #!/bin/bash

#format database
formatdb -p F -o T -i Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa

# loop through different counts of potential mismatch sites
# starting at 50, then incrementing by 50 each iteration, stopping at 950
for i in $(seq 50 50 950); do

# print the count of potential mismatch sites
echo $i

# loop through 100 iterations per mismatch site count 
for ((j=1; j<=100; j++)) ; do

# run  BLAST comparison
# count the number of times the accession number was found in the output (but with a maximum count of 1 per BLAST run)
msbar -sequence mysequence.fa -count $i -point 4 -block 0 -codon 0 -outseq mysample_mutated2.fa
blast2 -p blastn -e 0.001 -m 8 -d Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa -i mysample_mutated2.fa | grep "AAC76296" | head -1 | wc -l  

# close loop 2 and add up the number of matches out of the 100 runs
done | numsum

# close loop 1 and save output file
done  > output4.txt

