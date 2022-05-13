#!/bin/bash

while read file location
do
	echo "File is $file, location is $location"
	cp "$file" "$location/.$file"
done <<EOF
vimrc $HOME
bashrc $HOME
zshrc $HOME
hushlogin $HOME
gitignore $HOME
gdbinit $HOME
EOF
