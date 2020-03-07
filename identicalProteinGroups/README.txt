#This program is for extracting the identical protein groups from the NCBI database

#First, open ipg_retrieval.py and modify the two lines to include your "Entrez.email" and "apikey"

#To run the program, will need the accessions.txt that has the accession numbers

cat ../OriginalData/TcdA/tcda.ncbi ../OriginalData/TcdB/tcdb.ncbi >accessions.txt

#Then run the program
python ipg_retrieval.py

#This will create a ipg.txt file that contain all the ipgs for each protein

