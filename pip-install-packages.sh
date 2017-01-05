#!/bin/bash
set -e
set -x

mkdir -p ./downloaded_resources/pip-packages
#cd ./downloaded_resources/pip-packages

# shyaml requires d2to1
# for some reason, it must be installed in a previous separated command
pip install --no-index --find-links ./downloaded_resources/pip-packages --upgrade d2to1

pip install --no-index --find-links ./downloaded_resources/pip-packages --upgrade -r ./pip-packages-requirements.txt
