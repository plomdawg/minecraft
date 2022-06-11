.PHONY: default server run install uninstall backup

default: server install

server:
	/bin/bash scripts/download-fabric.sh

run:
	/bin/bash scripts/run-server.sh

install:
	/bin/bash scripts/setup-service.sh install

uninstall:
	/bin/bash scripts/setup-service.sh uninstall

backup:
	/bin/bash scripts/backup.sh
