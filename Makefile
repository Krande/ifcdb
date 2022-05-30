install:
	conda env create -f environment.yml

update:
	conda env update --file environment.yml --prune

local-itest:
	choco install act-cli

local-t:
	act -j test