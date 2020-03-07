#get data
cp ../../OriginalData/TcdB/tcdB_relabeled.fa .

#make BLAST db and run self-vs-self search
makeblastdb -in tcdB_relabeled.fa -dbtype 'prot'
blastp -outfmt "6" -query tcdB_relabeled.fa -db tcdB_relabeled.fa >toxinb.self


#then import toxinb.self into R and run plot.R
