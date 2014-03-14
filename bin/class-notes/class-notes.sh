#!/bin/sh
today=$(date +%Y-%m-%d)

filename=$today.md

cd lectures/

echo $today >> $filename
echo ========== >> $filename
echo >> $filename
echo >> $filename

vim -X +$ +star $filename
