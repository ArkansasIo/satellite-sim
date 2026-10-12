PYTHON ?= python3

.PHONY: mvp commercial extended test

mvp:
	$(PYTHON) generate.py --profile mvp

commercial:
	$(PYTHON) generate.py --profile commercial

extended:
	$(PYTHON) generate.py --profile extended

test:
	$(PYTHON) -m unittest discover -s tests -p 'test_*.py'
