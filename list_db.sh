#! /bin/bash

if [  -d "./DB" ]; then
	cd ./DB
	if [ "$(ls -F | grep -i '/') " ];then
		echo " list of database: "
		ls -F | grep "/"
	else
		echo "No DataBase Found"
	fi
else

	echo "there is no DataBase Dir!!"
fi
