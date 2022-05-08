conopt=--tls-security=insecure -P 5656

up:
	docker-compose up

migrate_init:
	edgedb $(conopt) migration create

migrate:
	edgedb $(conopt) migrate

types:
	edgedb $(conopt) list types