#!/usr/bin/env sh
# TODO paramterize
find ./ -type f -exec sed -i -e 's/24ffa6/00ff97/g' {} \;
