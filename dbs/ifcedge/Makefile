conopt=--tls-security=insecure -P 5656

up:
	docker-compose up

migrate-init:
	edgedb $(conopt) migration create

migrate:
	edgedb $(conopt) migrate

cli-update:
	edgedb cli upgrade

types:
	edgedb $(conopt) list types