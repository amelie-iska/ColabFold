#!/bin/bash

# Define the paths
db_path='/home/lily/amelie/Workspace/ColabFold/MsaServer/databases'
# input_fasta='/home/lily/amelie/Workspace/ColabFold/work/example.fasta'
input_fasta='/home/lily/amelie/Workspace/ColabFold/work/run-1_0.fa'

output_path="/home/lily/amelie/Workspace/ColabFold/work/outputs"
log_path="/home/lily/amelie/Workspace/ColabFold/work/logs"
cache_path="/home/lily/amelie/Workspace/ColabFold/alphafold2_cache"

# Run Docker container
time docker run --gpus all \
  -v "${db_path}:/database" \
  -v "${input_fasta}:/input.fasta" \
  -v "${output_path}:/predictions" \
  -v "${log_path}:/logs" \
  -v "${cache_path}:/cache" \
  ghcr.io/sokrypton/colabfold:1.5.5-cuda11.8.0 \
  /bin/bash -c "colabfold_search --mmseqs /usr/local/envs/colabfold/bin/mmseqs /input.fasta /database msas > /logs/search.log 2>&1 && colabfold_batch msas /predictions > /logs/batch.log 2>&1"