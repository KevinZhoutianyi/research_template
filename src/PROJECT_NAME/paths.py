"""Shared paths, independent of the process working directory."""

import os
from pathlib import Path

REPO_ROOT = Path(os.environ.get("PROJECT_ROOT", Path(__file__).resolve().parents[2])).resolve()
SRC_ROOT = REPO_ROOT / "src"
DATA_ROOT = SRC_ROOT / "data"
CONFIG_ROOT = SRC_ROOT / "configs"
EXPERIMENTS_ROOT = REPO_ROOT / "experiments"
