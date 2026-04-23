#!/usr/bin/env bash
set -euo pipefail

workspace_dir="${ROVER_WORKSPACE_DIR:-/workspace}"

mkdir -p "${workspace_dir}"

# Configure git safe directory for the workspace
git config --global --add safe.directory "${workspace_dir}"

# Clone the repository if not already present
if [ -n "${ROVER_GIT_REPOSITORY_URL:-}" ] && [ ! -d "${workspace_dir}/.git" ]; then
  repo_url="${ROVER_GIT_REPOSITORY_URL}"

  # Inject access token into the URL if available
  if [ -n "${ROVER_GIT_ACCESS_TOKEN:-}" ]; then
    repo_url=$(echo "${repo_url}" | sed "s|https://|https://oauth2:${ROVER_GIT_ACCESS_TOKEN}@|")
  fi

  echo "Cloning repository into ${workspace_dir}..."
  git clone "${repo_url}" "${workspace_dir}"
  echo "Clone complete."
fi

# Persist bash history in rover's home (on the volume, outside the repo)
export HISTFILE="/home/rover/.bash_history"
touch "${HISTFILE}"

cd "${workspace_dir}"

exec "$@"
