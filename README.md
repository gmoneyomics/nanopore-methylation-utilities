# Snakemake pipeline for calling methylation on nanopore sequence data 

# Dependencies
Install Minimap2 https://github.com/lh3/minimap2

Install Nanopolish https://github.com/jts/nanopolish

Install bcftools, samtools, htslib http://www.htslib.org/download/

Install nanopore-methylation-utilites https://github.com/timplab/nanopore-methylation-utilities

Install snakemake https://snakemake.readthedocs.io/en/stable/

# Setting up pipeline
All the workflows here expect all paths to softwares and data to exist in the config before they are included. 
The config.yaml file can be edited directly with the paths to these installed software packages and the path to fast5, fastq, reference, out path and number of cores
```
nanopolish: /home/Software/nanopolish
```

# Run pipeline
Once config file is updated for local path run the pipeline:

```
snakemake --snakefile call_meth_pipeline_config
```
# test
To test the pipeline:
Download test data and input paths into config
```
./test/get_test_dat.sh
snakemake --snakefile call_meth_pipeline_config
```

# Outputs
bed-style format methylation file
------
nanopore-methylation-utilites will convert nanopolish methylation calling output into bed-style format, such that each line is

|Contig |Start  |End  |Read name  |Methylation call string  |Log-likelihood ratios  |Motif context  |
|-------|-------|-----|-----------|-------------------------|-----------------------|---------------|

where Methylation call string is arranged such that 
- numbers are separated by methylation calls
- each number is cumulative distance from the "start"
- methylation call corresponds to the motif at position preceding the letter
- "m" means methylated, "u" means unmethylated, and "x" means uncalled (not confident)

The resulting bed-style file is sorted, [bgzipped](http://www.htslib.org/doc/bgzip.html), and [tabix](http://www.htslib.org/doc/tabix.html) indexed for easy manipulation.  


The bam file will be converted for IGV
------
Using the converted bed-style methylation file, the original bam file can be "bisulfite converted _in silico_" for easy visualization on IGV via their bisulfite mode.

For more information about nanopolish, minimap, or nanopore-methylation-utilies outputs visit their respective git repositories
