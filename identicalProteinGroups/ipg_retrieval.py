#import module
from Bio import Entrez

#retrieve accession numbers
f = open("accessions.txt", "r")
accn_numbers = []
for line in f:
	accn_numbers.append(str(line))

#email_address
Entrez.email = ""
#apikey
apikey = ""

#efetch the identical protein groups and write them to ipg.txt
output_file = open("ipg.txt", 'w')
for accn in accn_numbers:
	handle = Entrez.efetch(db = "protein", id = accn, api_key=apikey, rettype = "ipg", retmode =  "text")
	output_file.write(">" + str(accn) + "\n")	
	output_file.write(handle.read())
	output_file.write("\n")	
	print(accn)
	handle.close()
output_file.close()


