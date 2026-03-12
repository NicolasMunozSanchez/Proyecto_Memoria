#!/bin/bash

#SBATCH --job-name=mSIS_preprocess
#SBATCH --error=.logs/mSIS_preprocess.log
#SBATCH --output=.logs/mSIS_preprocess.log
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1
#SBATCH --time=02:00:0
#SBATCH --mem-per-cpu=15G
#SBATCH --gres=gpu:1
#SBATCH --gpus-per-task=1
#SBATCH --mail-type=END
#SBATCH --mail-user=nicolasa.munoz@pregrado.uoh.cl


mkdir -p .logs

singularity instance start --nv singularity/MouseE2Vid_v3.sif sinInsMouse

cd MouseSIS


singularity exec --nv instance://sinInsMouse \
python scripts/preprocess_events_to_e2vid_images.py --data_root data/MouseSIS


singularity instance stop sinInsMouse
