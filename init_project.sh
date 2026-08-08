#!/usr/bin/env bash
# Usage: ./init_project.sh <project_name> <destination_path>
# Example: ./init_project.sh myproject ~/projects/myproject
#
# Copies this template to a new directory and replaces PROJECT_NAME throughout.
# Only git-TRACKED files are copied (git archive), so local junk — venvs, tmp/,
# data/, caches, personal settings — never leaks into a new project.

set -e

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <project_name> <destination_path>"
    exit 1
fi

PROJECT_NAME="$1"
DEST="$2"
TEMPLATE_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -e "$DEST" ]; then
    echo "Error: '$DEST' already exists."
    exit 1
fi

# Refuse a destination inside the template tree (rsync/copy loops, junk nesting).
mkdir -p "$DEST"
DEST_ABS="$(cd "$DEST" && pwd)"
case "$DEST_ABS/" in
    "$TEMPLATE_DIR"/*)
        rmdir "$DEST_ABS"
        echo "Error: destination must be outside the template directory."
        exit 1
        ;;
esac

echo "Creating project '$PROJECT_NAME' at '$DEST_ABS'..."

# Copy tracked files only, excluding the init script itself
git -C "$TEMPLATE_DIR" archive HEAD | tar -x -C "$DEST_ABS"
rm -f "$DEST_ABS/init_project.sh"

# Replace PROJECT_NAME in all text files
find "$DEST_ABS" -type f \( -name "*.md" -o -name "*.toml" -o -name "*.json" -o -name "*.py" -o -name "*.yaml" -o -name "*.gitignore" \) | while read -r file; do
    sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" "$file"
done

# Rename the src package directory
if [ -d "$DEST_ABS/experiments/src/PROJECT_NAME" ]; then
    mv "$DEST_ABS/experiments/src/PROJECT_NAME" "$DEST_ABS/experiments/src/$PROJECT_NAME"
fi

# Create the gitignored data and tmp directories inside the repo
mkdir -p "$DEST_ABS/data/checkpoints" "$DEST_ABS/data/datasets" "$DEST_ABS/data/outputs" "$DEST_ABS/tmp"

# Initialize git with the language gate enabled from commit one
cd "$DEST_ABS"
git init
git config core.hooksPath .githooks
git add .
git commit -m "Initial commit from research_template"

echo ""
echo "Done! Project '$PROJECT_NAME' is ready at '$DEST_ABS' (git initialized, language gate enabled)."
echo ""
echo "Next steps:"
echo "  1. Edit CLAUDE.md — fill in the compute posture for this project"
echo "  2. Edit doc/weekly_updates/CLAUDE.md — set the usual weekly form (update vs slides)"
echo "  3. Edit pyproject.toml — adjust dependencies, then: cd $DEST_ABS && uv sync"
