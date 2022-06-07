conopt=--tls-security=insecure -P 5656


cli-install:
	PowerShell.exe -command "iwr https://ps1.edgedb.com -useb | iex"

up:
	docker-compose up

migrate-init:
	edgedb $(conopt) migration create --non-interactive --allow-unsafe

migrate:
	edgedb $(conopt) migrate

cli-update:
	edgedb cli upgrade

types:
	edgedb $(conopt) list types

# Use WSL Edgedb

wsl-instance:
	edgedb instance create ifcdb --nightly

wsl-instances:
	edgedb instance list

wsl-migrate-init:
	edgedb -I ifcdb migration create --non-interactive --allow-unsafe

wsl-migrate:
	edgedb -I ifcdb migrate

wsl-destroy:
	edgedb instance destroy ifcdb