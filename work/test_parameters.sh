db_path='/home/lily/amelie/Workspace/ColabFold/MsaServer/databases'
input_fasta='/home/lily/amelie/Workspace/LigandMPNN/outputs/default/seqs/run_1_0.fa'
output_path="/home/lily/amelie/Workspace/ColabFold/work/outputs/5TPN"
log_path="/home/lily/amelie/Workspace/ColabFold/work/logs"
cache_path="/home/lily/amelie/Workspace/ColabFold/alphafold2_cache"

docker run --gpus all \
  -v "${db_path}:/database" \
  -v "${input_fasta}:/input.fasta" \
  -v "${output_path}:/predictions" \
  -v "${cache_path}:/cache" \
  ghcr.io/sokrypton/colabfold:1.5.5-cuda11.8.0 \
  /bin/bash -c "colabfold_search --mmseqs /usr/local/envs/colabfold/bin/mmseqs /input.fasta /database msas && colabfold_batch colabfold_batch \
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
    msas /predictions"
    
# db_path='/home/lily/amelie/Workspace/ColabFold/MsaServer/databases'
# input_fasta='/home/lily/amelie/Workspace/LigandMPNN/outputs/default/seqs/run_1_0.fa'
# output_path="/home/lily/amelie/Workspace/ColabFold/work/outputs/5TPN"
# log_path="/home/lily/amelie/Workspace/ColabFold/work/logs"
# cache_path="/home/lily/amelie/Workspace/ColabFold/alphafold2_cache"

# time docker run --gpus all \
#   -v "${db_path}:/database" \
#   -v "${input_fasta}:/input.fasta" \
#   -v "${output_path}:/predictions" \
#   -v "${log_path}:/logs" \
#   -v "${cache_path}:/cache" \
#   ghcr.io/sokrypton/colabfold:1.5.5-cuda11.8.0 \
#   /bin/bash -c "colabfold_search --mmseqs /usr/local/envs/colabfold/bin/mmseqs /input.fasta /database msas > /logs/search.log 2>&1 && colabfold_batch colabfold_batch \
#     --num-recycle 6 \
#     --num-ensemble 1 \
#     --num-seeds 1 \
#     --stop-at-score 100 \
#     --msa-mode mmseqs2_uniref_env \
#     --pair-mode unpaired_paired \
#     --pair-strategy complete \
#     --templates \
#     --model-type auto \
#     --num-models 3 \
#     --amber \
#     --num-relax 1 \
#     --relax-max-iterations 200 \
#     --use-gpu-relax \
#     --rank plddt \ 
#     msas /predictions > /logs/batch.log 2>&1"