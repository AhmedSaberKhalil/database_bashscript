#! /bin/bash
PS3='connect db =>'
while true; do
read -r -p "enter your db that you need to connect to it: " db_name
if [[ ! "$db_name" =~ ^[a-zA-Z_]+$ ]] || [[ "$db_name" == *\\* ]]; then
	echo "please enter db name without numbers or speical char!"
else
	if [ -e ./DB/$db_name ]; then
		cd ./DB/$db_name
		break
	else
		echo "you entered name does not exist!"
	fi
fi
done

options=("create_table" "list_table" "insert_table" "select_from_table" "delete_from_table" "update_from_table" "exit")
select opt in "${options[@]}"
do
	case $opt in
		"create_table")
			echo "you chose to create table."
			/home/ahmed/create_table.sh
			;;
		"list_table")
			echo "you chose to list table"
			/home/ahmed/list_table.sh
			;;
		"insert_table")
	        	echo "you chose to insert table"
			/home/ahmed/insert_to_table.sh
			;;
		"select_from_table")
			echo "you chose to select from table"
			/home/ahmed/select_table.sh
			;;
		"delete_from_table")
			echo "you chose to delete from table"
			./delete_table.sh
			;;
		"update_from_table")
			echo "you chose to update from table"
			./update_table.sh
			;;
		"exit")
			echo "good by!"
			break
	esac

done

