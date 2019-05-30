 #!/bin/bash

#format database
formatdb -p F -o T -i Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa

# loop through different counts of potential mismatch sites
# starting at 50, then incrementing by 50 each iteration, stopping at 950
for i in $(seq 50 50 950); do

# printing the count of potential mismatch sites on the output file
echo $i

# loop through 100 iterations per nucelotide count 
for ((j=1; j<=100; j++)) ; do
msbar -sequence mysequence.fa -count $i -point 4 -block 0 -codon 0 -outseq mysample_mutated2.fa

blast2 -p blastn -e 0.001 -m 8 -d Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa -i mysample_mutated2.fa \
| grep "AAC76296" | head -1 | wc -l  

done | numsum
done  > output4.txt

