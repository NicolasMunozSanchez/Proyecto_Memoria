#!/bin/bash

#SBATCH --job-name=eventos_a_grises
#SBATCH --error=.logs/err_eventos_a_grises.err
#SBATCH --output=.logs/out_eventos_a_grises.out
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1
#SBATCH --time=02:00:0
#SBATCH --mem-per-cpu=15G
#SBATCH --nodelist=v100
#SBATCH --gres=gpu:1
#SBATCH --gpus-per-task=1
#SBATCH --mail-type=END
#SBATCH --mail-user=nicolasa.munoz@pregrado.uoh.cl

mkdir -p .logs

singularity instance start --nv singularity/E2Vid.sif eventos_a_grises

singularity exec --nv instance://eventos_a_grises \
python rpg_e2vid/run_reconstruction.py \
  -c rpg_e2vid/pretrained/E2VID_lightweight.pth.tar \
  -i MouseSIS/data/MouseSIS/top/val/eventos_seq25.zip \
  --auto_hdr \
  --show_events\
  --output_folder MouseSIS/data/MouseSIS/top/val/

singularity instance stop eventos_a_grises
