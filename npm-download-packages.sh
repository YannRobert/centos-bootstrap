#!/bin/bash
set -e
set -x

mkdir -p ./downloaded_resources/node_modules

cat npm-packages-requirements.txt | xargs npm install --prefix ./downloaded_resources/node_modules
