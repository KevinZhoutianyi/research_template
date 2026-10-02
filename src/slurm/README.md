# Scheduler launchers

Run from the repository root. Supply the site's account, partition, memory, time,
and GPU requests explicitly; this template has no cluster-specific defaults.

```bash
sbatch --account=ACCOUNT --partition=PARTITION --time=00:05:00 --mem=2G \
  src/slurm/run.sbatch python -m pytest -q
```

Activate the project environment before submission. Logs go to
`src/slurm/logs/`. Inspect queue state and saved outputs before moving dependencies
or restarting a job. A successful submission is not a completed experiment.
