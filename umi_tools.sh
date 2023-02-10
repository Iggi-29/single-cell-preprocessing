#! /bin/bash
umi_tools whitelist --stdin SRR95_raw.R1.fastq.gz \
                    --bc-pattern= CCCCCCCCCCCCCCCCNNNNNNNNNNNN \
                    --extract-method=string \
                    --log2stderr > SRR95_raw_whitelist.txt
                    
umi_tools extract --bc-pattern=CCCCCCCCCCCCCCCCNNNNNNNNNNNN  \
                  --stdin SRR95_raw.R1.fastq.gz \
                  --stdout SRR95_raw_R1_extracted.fastq.gz \
                  --read2-in SRR95_raw_R2.fastq.gz \
                  --read2-out= SRR95_raw_R2_extracted.fastq.gz \
                  --whitelist=SRR95_raw_whitelist.txt
                  
STAR --runThreadN 16 \
     --genomeDir hg38_noalt_junc85_99.dir \
     --readFilesIn SRR95_raw_R2_extracted.fastq.gz \
     --readFilesCommand zcat \
     --outFilterMultimapNmax 1 \
     --outSAMtype BAM SortedByCoordinate
     
featureCounts -a annotation.gtf \
              -o gene_assigned \
              -R BAM Aligned.sortedByCoord.out.bam \
              -T 16;            

samtools sort Aligned.sortedByCoord.out.bam.featureCounts.bam -o assigned_sorted.bam;
samtools index assigned_sorted.bam

umi_tools group -I assigned_sorted.bam --paired --group-out=groups.tsv --output-bam -S mapped_grouped.bam

umi_tools dedup -I mapped_grouped.bam --output-stats=deduplicated -S deduplicated.bam

umi_tools count --per-gene --gene-tag=XT --assigned-status-tag=XS --per-cell -I deduplicated.bam -S counts.tsv.gz


