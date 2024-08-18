#!/bin/bash
# db_path='/home/lily/amelie/Workspace/ColabFold/MsaServer/databases'
# input_fasta='/home/lily/amelie/Workspace/LigandMPNN/outputs/default/seqs/run_1_0.fa'
# output_path="/home/lily/amelie/Workspace/ColabFold/work/outputs"
# log_path="/home/lily/amelie/Workspace/ColabFold/work/logs"
# cache_path="/home/lily/amelie/Workspace/ColabFold/alphafold2_cache"

# time docker run --gpus all \
#   -v "${db_path}:/database" \
#   -v "${input_fasta}:/input.fasta" \
#   -v "${output_path}:/predictions" \
#   -v "${log_path}:/logs" \
#   -v "${cache_path}:/cache" \
#   ghcr.io/sokrypton/colabfold:1.5.5-cuda11.8.0 \
#   /bin/bash -c "colabfold_search --mmseqs /usr/local/envs/colabfold/bin/mmseqs /input.fasta /database msas > /logs/search.log 2>&1 && colabfold_batch msas /predictions > /logs/batch.log 2>&1"
db_path='/home/lily/amelie/Workspace/ColabFold/MsaServer/databases'
input_fasta='/home/lily/amelie/Workspace/LigandMPNN/outputs/default/seqs/run_1_0.fa'
output_path="/home/lily/amelie/Workspace/ColabFold/work/outputs"
log_path="/home/lily/amelie/Workspace/ColabFold/work/logs"
cache_path="/home/lily/amelie/Workspace/ColabFold/alphafold2_cache"

time docker run --gpus all \
  -v "${db_path}:/database" \
  -v "${input_fasta}:/input.fasta" \
  -v "${output_path}:/predictions" \
  -v "${log_path}:/logs" \
  -v "${cache_path}:/cache" \
  ghcr.io/sokrypton/colabfold:1.5.5-cuda11.8.0 \
  /bin/bash -c "colabfold_search --mmseqs /usr/local/envs/colabfold/bin/mmseqs /input.fasta /database msas > /logs/search.log 2>&1 && colabfold_batch --pair-mode unpaired_paired --num-recycle 6 --rank plddt --use-gpu-relax msas /predictions > /logs/batch.log 2>&1"