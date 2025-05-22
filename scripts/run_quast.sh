#!/bin/bash

# Exit on error
set -e

# Usage message
usage() {
    echo "Usage: $0 <hap1.fa> <hap2.fa> <output_merged.fa>"
    echo
    echo "Arguments:"
    echo "  <hap1.fa>           Haplotype 1 FASTA file"
    echo "  <hap2.fa>           Haplotype 2 FASTA file"
    echo "  <output_merged.fa>  Output merged FASTA file"
    echo
    echo "The merged FASTA will be passed to quast.py for evaluation."
    exit 1
}

# Check argument count
if [ "$#" -ne 3 ]; then
    usage
fi

# Assign input arguments
HAP1="$1"
HAP2="$2"
MERGED="$3"

# Merge haplotype FASTA files
cat "$HAP1" "$HAP2" > "$MERGED"

# Run QUAST on the merged FASTA
quast.py "$MERGED"

