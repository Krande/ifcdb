install:
	conda env create -f environment.yml

update:
	conda env update --file environment.yml --prune

local-itest:
	choco install act-cli

local-t:
	act -j test

docs-install:
	conda env create -f docs/environment.docs.yml

docs-update:
	conda env update --file docs/environment.docs.yml --prune

bdocs:
	activate ifcdb-docs && cd docs && make html

format:
	black . && isort . && flake8 .