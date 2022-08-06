conopt=--tls-security=insecure -P 5656


cli-install:
	PowerShell.exe -command "iwr https://ps1.edgedb.com -useb | iex"

# Docker Commands
up:
	docker-compose up -d

mig-i:
	docker-compose exec edgedb edgedb --tls-security=insecure migration create --non-interactive

mig:
	docker-compose exec edgedb edgedb --tls-security=insecure migrate


# Using local EdgeDB CLI (if installed)
migrate-init:
	edgedb $(conopt) migration create --non-interactive

migrate:
	edgedb $(conopt) migrate

cli-update:
	edgedb cli upgrade --to-nightly

types:
	edgedb $(conopt) list types

ui:
	edgedb $(conopt) ui

# Use WSL Edgedb
wsl-instance:
	edgedb instance create ifcdb --nightly

wsl-instances:
	edgedb instance list

wsl-migrate-init:
	edgedb -I ifcdb migration create --non-interactive

wsl-migrate:
	edgedb -I ifcdb migrate

wsl-destroy:
	edgedb instance destroy ifcdb