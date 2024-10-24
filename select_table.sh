#! /bin/bash

validate_name()
{
	local name="$*"
	if [[ ! "$name" =~ ^[a-zA-Z_]+$ ]] || [[ "$name" == *\\* ]]; then
		echo "please enter name without specials char or numbers!"
		return 1
	fi
	if [ ! -f "$name" ]; then
		echo "table $name does not exist, please try again!"
		return 1
	fi
	return 0
}

while true;
do
	read -r -p "please enter table name: " table_name
	if validate_name "$table_name"; then
		break
	else
		echo "try again!"
	fi
done
declare -a arr
while IFS= read -r line;
do
	col=$(echo "$line" | awk -F': ' '{print $2}' | awk -F ' ' '{print $1}' | tr -d "'")
	arr+=("$col")
done < "./$table_name.metadata"

options="${arr[@]}"
##for c in $options;
#do
#	echo $c
#done
echo " how you want to select data"
select opt in all byId
do
	case $opt in
		"all")
			awk -F, '{print}' $table_name
			break
			;;
		"byId")
			while true;
			do

				read -r -p "enter your id: " id
				if [[ "$id" =~ ^[0-9]+$ ]]; then
					result=$(awk -F',' -v  search_id="$id" '$1 == search_id {print $0}' $table_name)
					if [ -z "$result" ]; then
						echo "The id is not exist!, please try again"
					else

						awk -F',' -v  search_id="$id" '$1 == search_id {print $0}' $table_name
						break
					fi
				else
					"please enter just a number!"
				fi
			done
			break
			;;

		*)
			echo "invalied options"
			;;
	esac
done

