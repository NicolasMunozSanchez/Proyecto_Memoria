#!/bin/bash

#SBATCH --job-name=eventos_a_grises
#SBATCH --error=.logs/err_disponibilidadGPU.err
#SBATCH --output=.logs/out_disponibilidadGPU.out
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

singularity instance start --nv singularity/E2Vid.sif disponibilidadGPU

singularity exec --nv instance://disponibilidadGPU \
python disponibilidadGPU.py

singularity instance stop disponibilidadGPU
