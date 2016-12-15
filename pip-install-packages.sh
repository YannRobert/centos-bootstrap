#!/bin/bash
set -e
set -x
mkdir -p ./pip-packages
pip install --no-index --find-links ./pip-packages --upgrade -r ./pip-packages-requirements.txt
