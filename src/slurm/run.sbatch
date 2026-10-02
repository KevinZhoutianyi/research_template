#!/usr/bin/env bash
#SBATCH --output=/dev/null
# Supply resource requests with sbatch arguments for the current cluster.
set -euo pipefail
cd "${SLURM_SUBMIT_DIR:?Submit from the repository root}"
test -f pyproject.toml
mkdir -p src/slurm/logs
exec >"src/slurm/logs/job-${SLURM_JOB_ID}.log" 2>&1
exec srun "$@"
