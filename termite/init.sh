#!/bin/bash

if [ -z "$1" ]
  then
    echo "You need to pass in the name of the colorscheme file to build the config file" && exit 1
fi

if [ ! -f "$1" ]
  then
    echo "Colorscheme file: $1 not found" && exit 1
fi

cat base > config
cat $1 >> config

cp config ~/.config/termite/config
