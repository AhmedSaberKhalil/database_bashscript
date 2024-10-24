#! /bin/bash
validate_name()
{
	local name="$*"
	if [[ ! "$name" =~ ^[a-zA-Z_]+$ ]] || [[ "$name" = *\\* ]]; then
		echo "Invalied name! please do not enter special chars or numbers!"
		return 1
	fi
	if [ ! -e "./$name" ]; then
		echo "the file $name does not exist"
		return 1
	fi
	return 0
}
while true; 
do
	
	read -r -p "enter tbale name that you want to insert data into: " table_name
	if validate_name "$table_name"; then

		break
	else
		echo "please try again!"
	fi
done
declare -a arr
while IFS= read -r line; 
do
	col=$(echo "$line" | awk -F': ' '{print $2}' | awk -F ' ' '{print $1}' | tr -d "'")
	arr+=("$col")
done < "./$table_name.metadata"

for c in "${arr[@]}";
do
	echo "col value $c "
done
generate_unique_id()
{
	if [[ " ${arr[@]} " =~ " id " ]]; then
		if [ -s "./$table_name" ]; then
			last_id=$(tail -n 1 "./$table_name" | cut -d',' -f1)
			new_id=$((last_id + 1))
		else
			new_id=1
		fi
		echo $new_id
	else
		echo "Table does not have an id column!"
		exit
	fi
}

echo "please enter data for each column:"
declare -a row_data
for col in "${arr[@]}";
do
	if [ "$col" == id ]; then
		unique_id=$(generate_unique_id)
		echo "field id auto assigned: $unique_id"
		row_data+=("$unique_id")
	else
		while true;
	       	do
			read -r -p "enter value for $col column: " value
			value=$(echo "$value" | sed 's/ /_/g')
			if [[ ! "$value" =~ ^[a-zA-Z0-9_]+$ ]] || [[ "$value" == *\\* ]]; then
				echo "Invalied input, please do not enter special chars or numbers!"
			else
				row_data+=("$value")
				break
			fi
		done
	fi	
done

echo "${row_data[*]}" | sed 's/ /,/g' >> "./$table_name"
echo "data successfully inserted into $table_name"
