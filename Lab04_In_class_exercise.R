# TASK 1 
library(biomaRt) # an alternative for annotation

listMarts() #default host is ensembl.org, and most current release of mammalian genomes
#listMarts(host="parasite.wormbase.org") #access to parasite worm genomes
#listMarts(host="protists.ensembl.org") #access to protozoan genomes

#choose the 'mart' you want to work with
myMart <- useMart(biomart="ENSEMBL_MART_ENSEMBL")
#take a look at all available datasets within the selected mart
available.datasets <- listDatasets(myMart)
#now grab the ensembl annotations for dog
ferret.anno <- useMart(biomart="ENSEMBL_MART_ENSEMBL", dataset = "mpfuro_gene_ensembl")
ferret.attributes <- listAttributes(ferret.anno)

Tx.ferret <- getBM(attributes=c('ensembl_transcript_id',
                                'external_gene_name',
                                'start_position',
                                'end_position',
                                'external_gene_name',
                                'description',
                                'entrezgene_id',
                                'pfam'),
                                mart = ferret.anno)

Tx.ferret <- as_tibble(Tx.ferret)
#we need to rename the two columns we just retreived from biomart
Tx.ferret <- dplyr::rename(Tx.ferret, target_id = ensembl_transcript_id_version, 
                        gene_name = external_gene_name)

# Task 2  

seq <- getSequence(id=c("MX1", "IFIT2", "OAS2", "IRF1", "IFNAR1"),
                   type="hgnc_symbol",
                   seqType="gene_flank",
                   upstream= 1000,
                   mart= ferret.anno
        )

seq
