#!/bin/bash

#SBATCH --job-name=MouseSIS_preprocess
#SBATCH --error=.logs/err_train1.err
#SBATCH --output=.logs/out_train1.out
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

singularity instance start --nv singularity/MouseSIS_preprocess.sif sinInsMouse

cd MouseSIS


singularity exec --nv instance://sinInsMouse \
python scripts/preprocess_events_to_e2vid_images.py --data_root data/MouseSIS


singularity instance stop sinInsMouse
