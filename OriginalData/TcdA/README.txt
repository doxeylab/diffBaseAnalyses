cat groups/*.relabeled.fa >tcdA.relabeled.fa

muscle -in tcdA.relabeled.fa -out tcdA.relabeled.afa

#opened tcdA.relabeled.afa in Seaview and truncated alignment to region 1-1874 to remove CROPS

-> tcdA_relabeled_1-1874.afa
