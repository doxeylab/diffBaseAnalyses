# diffBaseAnalyses

This repo contains scripts for the analyses and plots associated with diffBase https://github.com/doxeylab/diffBase

## Requirements

Standalone BLAST++ - ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/
R - https://www.r-project.org/

## Overview

* TcdA and TcdB sequences were first retrieved from the NCBI database using BLAST. Each set of sequences were aligned to generate MSAs that were further processed to remove partial and redundant sequences. Sequences were then clustered into groups. Sequence alignments for TcdA and B and associated sequence groups are included in: /OriginalData

* BLAST was then used to analyze within vs between group similarities. Scripts for running an all-by-all BLAST, parsing output, and generating plots in R are included in: /withinVsBetweenGroupSims

* Next, additional TcdA and TcdB sequences were mined from the NCBI Short Read Archive (https://www.ncbi.nlm.nih.gov/sra). Novel sequences (those with at least one aa variant compared to NCBI ref sequences) were then identified. BLAST was used to evaluate their similarities to the NCBI-based sequence clusters for TcdA and TcdB. This analysis is included in: /SRA-BLAST

* Lastly, a new tree including both the NCBI reference sequences and the novel SRA sequences was constructed.
