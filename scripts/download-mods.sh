#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# Directory containing this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REPO_DIR="$(realpath "${SCRIPT_DIR}/..")"

# Directory to download the mods into.
MODS_DIR="${REPO_DIR}/server/mods"
mkdir --parent --verbose "${MODS_DIR}"
pushd "${MODS_DIR}"

# Dynmap - https://github.com/webbukkit/dynmap
# https://www.reddit.com/r/Dynmap/comments/v76g95/dynmap_support_for_119_is_in_progress/
DYNMAP_JAR="Dynmap-3.4-SNAPSHOT-fabric-1.19.jar"
if [[ ! -f "${DYNMAP_JAR}" ]]; then
    wget "https://dynmap.us/builds/dynmap/${DYNMAP_JAR}"
fi


# FabricAPI - https://www.curseforge.com/minecraft/mc-mods/fabric-api
FABRIC_API_JAR="fabric-api-0.55.3+1.19.jar"
if [[ ! -f "${FABRIC_API_JAR}" ]]; then
    wget "https://media.forgecdn.net/files/3823/269/fabric-api-0.55.3%2B1.19.jar"
fi
