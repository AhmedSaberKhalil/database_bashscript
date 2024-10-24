#! /bin/bash

if [ "$(ls -p | grep -v /)" ]; then
	echo "your files:-"
	ls -p | grep -v /
else
	echo "No files founded!"
fi

