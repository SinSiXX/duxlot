#!/bin/bash

# Copyright 2012, Sean B. Palmer
# Code at http://inamidst.com/duxlot/
# Apache License 2.0

cd $(cat ~/.duxlot-src)
echo In $PWD

echo Updating version number
python3 -c 'import api; print(api.version_number())' > data/version
cat data/version

echo Running python updates
python3 prepare.py

echo Cleaning up files
rm -rf ./dist/
rm -rf ./__pycache__/
find . -name '*.pyc' -exec rm {} \;
find . -name '*.pyo' -exec rm {} \;
find . -name '.DS_Store' -exec rm {} \;

echo Creating distribution, and uploading to the CheeseShop
python3 setup.py sdist --formats=bztar upload -r 'test'

echo Moving distribution into place
rm -f ../*.tar.bz2
mv dist/*.tar.bz2 ../

echo Cleaning up files
rm -rf ./dist/
rm -rf ./__pycache__/
find . -name '*.pyc' -exec rm {} \;
find . -name '*.pyo' -exec rm {} \;
find . -name '.DS_Store' -exec rm {} \;

echo Upload to Github
git add -A && git commit && git push origin master