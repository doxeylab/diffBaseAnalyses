#This program is for extracting the identical protein groups from the NCBI database

#First, open ipg_retrieval.py and modify the two lines to include your "Entrez.email" and "apikey"

#To run the program, will need the accessions.txt that has the accession numbers

cat ../OriginalData/*/*allBLASThits.fa | grep ">" | tr -d ">" | awk '{print $1}' >accessions.txt

#Then run the program
python ipg_retrieval.py

#This will create a ipg.txt file that contain all the ipgs for each protein


#next, we can now map the presence/absence of TcdA and TcdB sequence clusters/groups onto a tree of NCBI-based C. difficile genomes

#a tree can be found here
#must first modify the output labels to report the genome accession
https://www.ncbi.nlm.nih.gov/genome/tree/535

#this will produce the file "genomeTree.nwk"

#In R, do following:

library(ape)
tree <- read.tree("genomeTree.nwk")
writeLines(tree$tip.label)

#then copy and paste output to tree.tiplabels

#then run following in shell
cat tree.tiplabels | awk -F '/' '{print $3}' | awk -F '.' '{print $1}'

#back in R
#copy this back to tree$tip.label

write.tree(tree,file="genomeTree.corrected.nwk")
