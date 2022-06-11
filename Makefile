.PHONY: default server run install uninstall backup restart

default: server install

server:
	/bin/bash scripts/download-fabric.sh
	/bin/bash scripts/download-mods.sh

run:
	/bin/bash scripts/run-server.sh

install:
	/bin/bash scripts/setup-service.sh install

uninstall:
	/bin/bash scripts/setup-service.sh uninstall

backup:
	/bin/bash scripts/backup.sh

restart:
	sudo systemctl restart minecraft
	sudo systemctl status minecraft

logs:
	journalctl -u minecraft -f
