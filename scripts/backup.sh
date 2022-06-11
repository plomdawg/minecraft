#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# Directory containing this script.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REPO_DIR="$(realpath "${SCRIPT_DIR}/..")"

# Where to store the backup files.
BACKUP_DIR="${REPO_DIR}/backups"
BACKUP_FILE="${BACKUP_DIR}/$(date +"%F--%H.%M.%S").tar.gz"

# Create backup directory if it's missing.
if [[ ! -d "${BACKUP_DIR}" ]]; then
	mkdir --verbose --parents "${BACKUP_DIR}"
fi

# Location of MC server.
SERVER_DIR="${REPO_DIR}/server"

# Create a tarball containing the world.
tar \
	--create \
	--verbose \
	--gzip \
	--preserve-permissions \
	--exclude="${SERVER_DIR}/backups" \
	--exclude="${SERVER_DIR}/logs" \
	--exclude="${SERVER_DIR}/*.log" \
	--exclude="${SERVER_DIR}/libraries" \
	--exclude="${SERVER_DIR}/versions" \
	--file "${BACKUP_FILE}" \
	"${SERVER_DIR}"	

echo "Created backup: ${BACKUP_FILE}"

# Delete backups older than 4 days.
find "${BACKUP_DIR}" -mtime +4 -type f -delete

