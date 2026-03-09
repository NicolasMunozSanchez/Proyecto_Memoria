#!/bin/bash

#SBATCH --job-name=MouseSIS
#SBATCH --error=.logs/MouseSIS.log
#SBATCH --output=.logs/MouseSIS.log
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=2
#SBATCH --time=08:00:0
#SBATCH --mem-per-cpu=50G
#SBATCH --nodelist=v100,v100
#SBATCH --gres=gpu:2
#SBATCH --gpus-per-task=1
#SBATCH --mail-type=END
#SBATCH --mail-user=nicolasa.munoz@pregrado.uoh.cl

mkdir -p .logs

echo "Inicio: $(date)"
start=$(date +%s)



singularity instance start --nv singularity/MouseE2Vid_v3.sif sinInsMouse

cd MouseSIS


singularity exec --nv instance://sinInsMouse \
python3 scripts/inference.py --config configs/predict/quickstart.yaml

singularity exec --nv instance://sinInsMouse \
python scripts/eval.py --TRACKERS_TO_EVAL quickstart --SPLIT_TO_EVAL val


singularity instance stop sinInsMouse



end=$(date +%s)
runtime=$((end - start))
echo "Fin: $(date)"

hours=$((runtime / 3600))
minutes=$(( (runtime % 3600) / 60 ))
seconds=$((runtime % 60))
printf "Tiempo total de ejecución: %02d:%02d:%02d (hh:mm:ss)\n" $hours $minutes $seconds
