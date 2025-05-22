#!/bin/bash

# Exit on error
set -e

# Usage message
usage() {
    echo "Usage: $0 <reads.fastq.gz> <hap1.fa> <hap2.fa> <merqury_path>"
    echo
    echo "Arguments:"
    echo "  <reads.fastq.gz>   Compressed FASTQ reads file"
    echo "  <hap1.fa>          Haplotype 1 contig FASTA"
    echo "  <hap2.fa>          Haplotype 2 contig FASTA"
    echo "  <merqury_path>     Path to merqury.sh script"
    echo
    echo "Output will be written to 'meryl_read_counts' and 'out'"
    exit 1
}

# Check arguments
if [ "$#" -ne 4 ]; then
    usage
fi

# Assign input arguments
READS_FASTQ="$1"
HAP1_FA="$2"
HAP2_FA="$3"
MERQURY="$4"

# Run meryl to count k-mers
meryl count k=21 "$READS_FASTQ" output meryl_read_counts

# Run Merqury with the generated meryl database and haplotype assemblies
"$MERQURY/merqury.sh" meryl_read_counts "$HAP1_FA" "$HAP2_FA" out

