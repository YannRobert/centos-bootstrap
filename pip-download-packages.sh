#!/bin/bash
set -e
set -x
mkdir -p ./pip-packages
pip download --dest ./pip-packages -r ./pip-packages-requirements.txt
