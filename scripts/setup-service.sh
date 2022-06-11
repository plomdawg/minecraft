#!/bin/bash
set -o errexit
set -o pipefail

function usage(){
    echo "Usage: "
    echo "${1} install   - Install service to run the server."
    echo "${1} uninstall - Remove service that runs the server."
    exit 1
}

# Run as root.
if [[ "${EUID}" != 0 ]]; then
  echo "Invoking script as root"
  sudo ${0} ${@}
  exit $?
fi

# Directory containing this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Server directory.
SERVER_DIR="$(realpath "${SCRIPT_DIR}/../server")"

# Set up the systemd service to run the server.

if [[ "${1}" == "install" ]]; then
    echo "Installing systemd service."
        
    # Add the systemd service.
    cat <<SYSTEMD_SERVICE >/etc/systemd/system/minecraft.service
[Unit]
Description=Minecraft Server.
After=network.target

[Service]
Type=simple
User=avalon
WorkingDirectory=${SERVER_DIR}
ExecStart=/bin/bash ${SCRIPT_DIR}/run-server.sh
RestartSec=5
Restart=on-failure

[Install]
WantedBy=multi-user.target
Alias=minecraft.target
SYSTEMD_SERVICE

    # Reload systemd.
    systemctl daemon-reload

    # Enable the service.
    systemctl enable --now minecraft.service

    echo "Installed systemd service. View logs with:"
    echo "journalctl -u minecraft -f"

elif [[ "${1}" == "uninstall" ]]; then 
    echo "Uninstalling systemd service."
    # Disable the service.
    systemctl stop minecraft.service || true
    systemctl disable minecraft.service

    # Remove the service file
    rm --verbose /etc/systemd/system/minecraft.service

else
    echo "Unknown command: ${1}."
    usage
fi