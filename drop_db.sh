#! /bin/bash
cd ./DB
PS3='drop database option: '
if [ ! "$(ls -F | grep '/')" ]; then
	echo " there is no database to deleted!!"
else

	while true;
	do
		read -r -p "please enter database name that you need to delete it: " db_name 
		
		if [[ ! "$db_name" =~ ^[a-zA-Z_]+$ ]] || [[ "$db_name" == *\\* ]]; then
			echo " Invalied database name. please do enter special char or number!"
		else
			if [ ! -e $db_name ]; then
				echo "you entered database name dos not exist! please try again: "
			else
				
				rm -r ./$db_name
				echo "you deleted $db_name database " 
				break
			fi

		fi
	done

fi
