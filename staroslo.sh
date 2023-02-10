#! /bin/bash
STAR --soloType CB_UMI_Simple --genomeDir ./index_star/index/ --soloCBwhitelist ./barcodes/3M-february-2018.txt --soloUMIlen 12 --readFilesCommand zcat --readFilesIn ./SRR12965697_10_trim_1.fastq.gz ./SRR12965697_10_trim_2.fastq.gz --soloCellFilter TopCells 400  --soloUMIdedup 1MM_CR --outFileNamePrefix ./little/littlecells --runThreadN 16

