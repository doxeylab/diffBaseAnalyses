#get data
cp ../../OriginalData/TcdA/tcdA_relabeled.fa .

#make BLAST db and run self-vs-self search
makeblastdb -in tcdA_relabeled.fa -dbtype 'prot'
blastp -outfmt "6" -query tcdA_relabeled.fa -db tcdA_relabeled.fa >toxina.self


#then import toxinb.self into R and run plot.R
