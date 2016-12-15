#!/bin/bash
set -e

# disable the bell (on the console don't ring the bell on user input alert)
perl -i -pe 's/^#set bell-style none/set bell-style none/' /etc/inputrc
