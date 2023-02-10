#! /bin/bash
kallisto index ./genomes/Mus_musculus.GRCm38.dna.primary_assembly.fa

kallisto bus -i ./index/mus_index.idx -o ./out/fastp/SRR95/ -x 10xv3 -t 7 ./fastp/SRR12965695/out_SRR12965695/SRR12965695_trim_1.fastq.gz ./fastp/SRR12965695/out_SRR12965695/SRR12965695_trim_2.fastq.gz

bustools correct -w ./10x_version3_whitelist.txt -p ./out/raw/SRR95/output.bus | bustools sort -T tmp/ -t 7 -p - | bustools count -o ./genecounts/genes -g ./index/mus_t2g.txt -e ./out/raw/SRR95/matrix.ec -t ./out/raw/SRR95/transcripts.txt --genecounts -


