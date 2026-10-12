PYTHON ?= python3

.PHONY: generate test

generate:
	$(PYTHON) generate.py

test:
	$(PYTHON) -m unittest discover -s tests -p 'test_*.py'
