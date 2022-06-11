#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# Directory containing this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Jar file is in the server directory.
JAR="$(realpath ${SCRIPT_DIR}/../server/fabric.jar)"

# Run the Minecraft server.
java -Xms2G -Xmx15G -jar "${JAR}" nogui
