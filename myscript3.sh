 #!/bin/bash


#format database
formatdb -p F -o T -i Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa

# loop through different nucleotide counts
for j in {1..10}; do
msbar -sequence mysequence.fa -count j -point 4 -block 0 -codon 0 -outseq mysample_mutated2.fa

blast2 -p blastn -e 0.001 -m 8 -d Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa -i mysample_mutated2.fa
done
