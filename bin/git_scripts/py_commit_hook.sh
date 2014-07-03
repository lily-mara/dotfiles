#!/bin/sh
# Auto-check for pep8 so I don't check in bad code
FILES=$(git diff --cached --name-only --diff-filter=ACM | grep -e '\.py$')

if [ -n "$FILES" ]; then
	flake8 --ignore=W191 $FILES
fi

./run_tests.py
