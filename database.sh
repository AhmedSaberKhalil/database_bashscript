#! /bin/bash

if [ ! -e "./DB" ]; then
	echo "Dir DB does not exist!! Creating it."
	mkdir ./DB
	echo "Dir DB created."
else
	echo "Dir DB already exist."
fi

PS3='you in DB Directory.Please enter your choice : '
options=("create_db" "list_db" "drop_db" "connect_db" "exit")
select opt in "${options[@]}"
do
	case $opt in
		"create_db")
			echo "you chose to create a database"
			
			./create_db.sh
			;;
		"list_db")
			echo "you chose to list a database"
			./list_db.sh
			;;
		"drop_db")
			echo "you chose to drop a database"
			./drop_db.sh
			;;
		"connect_db")
			echo "you chose to connect a database"
			./connect_db.sh
			;;
		"exit")
			echo "good by!!"
		break
		;;
	*)
		echo "Invalied Optoons"
	esac
done
