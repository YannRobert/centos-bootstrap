#!/bin/bash
set -e
set -x

mkdir -p ./downloaded_resources/pip-packages
#cd ./downloaded_resources/pip-packages

# shyaml requires d2to1
# for some reason, it must be installed in a previous separated command
# so let's download it also in a separated command
pip download --dest ./downloaded_resources/pip-packages d2to1

pip download --dest ./downloaded_resources/pip-packages -r ./pip-packages-requirements.txt
