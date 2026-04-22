#!/usr/bin/env bash
set -euo pipefail

workspace_dir="${ROVER_WORKSPACE_DIR:-/workspace}"

mkdir -p "${workspace_dir}"
cd "${workspace_dir}"

# Configure git safe directory for the workspace
git config --global --add safe.directory "${workspace_dir}"

exec "$@"
