# IFC in EdgeDB

An experiment with storing IFC elements in EdgeDB

## Manual

Here are the steps (that at least worked last time I tried):

* Install EdgeDB CLI using Powershell `iwr https://ps1.edgedb.com -useb | iex` or use `make cli-install`
* Make sure docker is running (f.ex. start Docker Desktop)
* start docker-compose by `docker-compose up` from this dir (or `make up` if you prefer makefiles)
* run `make migrate-init` to initiate schema migration
* run `make migrate` to complete migration of schema
* Open main.py and run python script


## Pro's and Con's


## Resources

