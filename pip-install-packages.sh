#!/bin/bash
set -e
set -x

mkdir -p ./downloaded_resources/pip-packages
cd ./downloaded_resources/pip-packages

pip install --no-index --find-links ./downloaded_resources/pip-packages --upgrade -r ./pip-packages-requirements.txt
