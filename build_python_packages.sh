#!/bin/bash

if [ "$1" = "clean" ]
then
    rm -rf build fancymaps.egg-info dist
    exit 0
fi

cat setup.cfg.in | sed "s|#NAME#|${AUTHOR_NAME}|g" | sed "s|#EMAIL#|${AUTHOR_EMAIL}|g" > setup.cfg
version=$(grep version setup.py | cut -d"=" -f2 | rev | cut -c 2- | rev | tr -d "'")

repo=pypi
python setup.py sdist bdist_wheel
python -m twine upload --repository ${repo} "dist/fancymaps-${version/v/}"*
