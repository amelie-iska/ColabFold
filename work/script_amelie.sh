#!/bin/bash

# Set input and output directories
INPUT_DIR="~/amelie/Workspace/ColabFold/work/RFDiffusion-Cx26_5era-1K/seqs"
OUTPUT_DIR="~/amelie/Workspace/ColabFold/work/output-Cx26-5era"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Docker command
docker run --user $(id -u) -ti --rm --runtime=nvidia --gpus all \
-v ~/amelie/Workspace/alphafold2_cache:/cache:rw \
-v ~/amelie/Workspace/ColabFold/work:/work:rw \
ghcr.io/sokrypton/colabfold:1.5.5-cuda11.8.0 \
bash -c '
for file in /work/RFDiffusion-Cx26_5era-1K/seqs/*.fa; do
    output_dir="/work/output-Cx26-5era/$(basename "${file%.*}")"
    mkdir -p "$output_dir"
    colabfold_batch \
    --num-recycle 6 \
    --num-ensemble 1 \
    --num-seeds 1 \
    --stop-at-score 100 \
    --msa-mode mmseqs2_uniref_env \
    --pair-mode unpaired_paired \
    --pair-strategy complete \
    --templates \
    --model-type auto \
    --num-models 3 \
    --amber \
    --num-relax 1 \
    --relax-max-iterations 200 \
    --use-gpu-relax \
    --rank plddt \
    "$file" "$output_dir"
done
'