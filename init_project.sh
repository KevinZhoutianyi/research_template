#!/usr/bin/env bash
# Usage: ./init_project.sh <project_name> <destination_path>
# Example: ./init_project.sh myproject ~/projects/myproject
#
# Copies this template to a new directory and replaces PROJECT_NAME throughout.

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

echo "Creating project '$PROJECT_NAME' at '$DEST'..."

# Copy template, excluding the init script itself and git history
rsync -a --exclude='.git' --exclude='init_project.sh' "$TEMPLATE_DIR/" "$DEST/"

# Replace PROJECT_NAME in all text files
find "$DEST" -type f \( -name "*.md" -o -name "*.toml" -o -name "*.json" -o -name "*.py" -o -name "*.yaml" -o -name "*.gitignore" \) | while read -r file; do
    sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" "$file"
done

# Rename the src package directory
if [ -d "$DEST/src/PROJECT_NAME" ]; then
    mv "$DEST/src/PROJECT_NAME" "$DEST/src/$PROJECT_NAME"
fi

# Create the data directory outside the repo
DATA_DIR="/data/$PROJECT_NAME"
mkdir -p "$DATA_DIR/checkpoints" "$DATA_DIR/datasets" "$DATA_DIR/outputs"
echo "Created data directory at $DATA_DIR"

# Initialize git
cd "$DEST"
git init
git add .
git commit -m "Initial commit from ml-research-template"

echo ""
echo "Done! Project '$PROJECT_NAME' is ready at '$DEST'."
echo ""
echo "Next steps:"
echo "  1. Edit CLAUDE.md — fill in your name and research focus"
echo "  2. Edit pyproject.toml — adjust dependencies for your project"
echo "  3. Run: cd $DEST && uv sync"
