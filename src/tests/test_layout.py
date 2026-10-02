"""Portable layout contract for both the template and initialized projects."""

from pathlib import Path
import importlib
import tomllib

ROOT = Path(__file__).resolve().parents[2]


def test_shared_directories():
    for name in ("configs", "data", "tests", "slurm"):
        assert (ROOT / "src" / name).is_dir()
        assert not (ROOT / name).exists()


def test_package_paths():
    project = tomllib.loads((ROOT / "pyproject.toml").read_text())
    package = project["project"]["name"]
    paths = importlib.import_module(f"{package}.paths")
    assert paths.REPO_ROOT == ROOT
    assert paths.DATA_ROOT == ROOT / "src/data"
    assert paths.CONFIG_ROOT == ROOT / "src/configs"
    assert paths.EXPERIMENTS_ROOT == ROOT / "experiments"
    assert project["tool"]["hatch"]["build"]["targets"]["wheel"]["packages"] == [f"src/{package}"]


def test_result_and_archive():
    assert (ROOT / "doc/result.md").is_file()
    assert (ROOT / "archive/MANIFEST.md").is_file()
    assert (ROOT / "experiments/01_example/README.md").is_file()
