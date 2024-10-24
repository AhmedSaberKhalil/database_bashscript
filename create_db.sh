#! /bin/bash
database_name(){

	local db_name="$*"
	echo "the database you enter is: " $db_name	
        db_name=$(echo "$db_name" | sed 's/ /_/g')
	if [[ "$db_name" == *\\* ]] || [[ "$db_name" == *\/* ]]; then
		echo "Backslashes are not allowed."
		return 1
	fi
	if [[ ! "$db_name" =~ ^[a-zA-Z_]+$ ]]; then
		echo "Invalied database name!! please enter valied name with only letters and underscores"
		return 1
	fi

	if [ -e "./DB/$db_name" ];then
		echo "a database with the '$db_name' already exist"
		return 1
	fi
	echo "$db_name"
	return 0
}
while true;
do
	read -r -p "enter the name of the new database: " db_name
	if database_name "$db_name"; then 
		db_name=$(echo "$db_name" | sed 's/ /_/g')
		mkdir "./DB/$db_name"
		echo "database '$db_name' created successfully in ./DB/"
		break
	else
		echo "pleasr try agin !!"
	fi
done
