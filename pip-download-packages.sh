#!/bin/bash
set -e
set -x

mkdir -p ./downloaded_resources/pip-packages
#cd ./downloaded_resources/pip-packages

pip download --dest ./downloaded_resources/pip-packages -r ./pip-packages-requirements.txt
