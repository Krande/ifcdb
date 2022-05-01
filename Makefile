install:
	conda env create -f environment.yml

update:
	conda env update --file environment.yml --prune