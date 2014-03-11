#!/bin/sh
today=$(date +%Y-%m-%d)

mkdir NOTES--$today/
cd NOTES--$today/

echo $today >> README.md
echo ========== >> README.md
echo >> README.md
echo >> README.md

vim -X +$ +star README.md
