#!/bin/bash

# This script is now deprecated and replaced by the colabfold_wrapper.py
# It's kept for reference purposes only

echo "This script is deprecated. Please use the colabfold_wrapper.py in the misc_scripts directory instead."
exit 1

# The following is the old content of the script, kept for reference:

# # Define the paths
# HOME_DIR="/home/lily/amelie/Workspace"
# DB_PATH="$HOME_DIR/ColabFold/MsaServer/databases"
# INPUT_FASTA="$HOME_DIR/ColabFold/work/run-$1_0.fa"
# OUTPUT_PATH="$HOME_DIR/ColabFold/work/outputs"
# LOG_PATH="$HOME_DIR/ColabFold/work/logs"
# CACHE_PATH="$HOME_DIR/ColabFold/alphafold2_cache"

# # Ensure the output and log directories exist
# mkdir -p "$OUTPUT_PATH"
# mkdir -p "$LOG_PATH"

# # Run Docker container
# docker run --gpus all \
#   -v "${DB_PATH}:/database" \
#   -v "${INPUT_FASTA}:/input.fasta" \
#   -v "${OUTPUT_PATH}:/predictions" \
#   -v "${LOG_PATH}:/logs" \
#   -v "${CACHE_PATH}:/cache" \
#   ghcr.io/sokrypton/colabfold:1.5.5-cuda11.8.0 \
#   /bin/bash -c "colabfold_search --mmseqs /usr/local/envs/colabfold/bin/mmseqs /input.fasta /database msas > /logs/search.log 2>&1 && colabfold_batch msas /predictions > /logs/batch.log 2>&1"