conopt=--tls-security=insecure -P 5656

up:
	docker-compose up

migrate-init:
	edgedb $(conopt) migration create --non-interactive --allow-unsafe

migrate:
	edgedb $(conopt) migrate

cli-install:
	PowerShell.exe -command "iwr https://ps1.edgedb.com -useb | iex"

cli-update:
	edgedb cli upgrade

types:
	edgedb $(conopt) list types