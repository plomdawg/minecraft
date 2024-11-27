#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# Directory containing this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Download fabric. URL from https://fabricmc.net/use/server/
URL="https://meta.fabricmc.net/v2/versions/loader/1.21.3/0.16.9/1.0.1/server/jar"
JAR="$(realpath ${SCRIPT_DIR}/../server/fabric.jar)"

wget "${URL}" --output-document="${JAR}"

