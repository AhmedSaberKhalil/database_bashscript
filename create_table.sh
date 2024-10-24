#! /bin/bash
validate_table(){
	local table_name="$*"
	if [[ ! "$table_name" =~ ^[a-zA-Z_]+$ ]] || [[ "$table_name" == *\\* ]]; then
		echo "invalied name please enter table name without spaces or special chars or numbers"
		return 1
	fi
	if [ -f "./$table_name" ] || [ -f "./{$table_name}_metadata" ]; then
		echo "table name already exist"
		return 1
	fi
	return 0
}
while true;
do
	read -r -p "please enter the name of table name: " table_name

	if validate_table "$table_name"; then
		echo " you entered valied name."

		break
	else
		"please enter avalied name!"
	fi
done

while true ;
do
       read -r -p "enter the number of fileds: " num
	if [[ ! "$num" =~ [0-9]+$ ]] || [[ "$num" == *\\* ]] ; then
		echo " please enter just number!"
	else
		p_table_name=./$table_name
		touch $p_table_name
		s_table_name="./$table_name.metadata"
		touch $s_table_name
		break
	fi
done

validate_fileds(){
	local value="$*"
	#if [[ ! "$val" =~ ^[a-zA-z_]+$ ]] || [[ "$val" == *\\* ]]; then
	if [[ ! "$value" =~ ^[a-zA-Z_]+$ ]] || [[ "$value" == *\\* ]]; then
		echo "please enter avalid field without numbers or special chars!"
		return 1
	fi
	return 0
}

for ((i=1; i <= $num; i++));
do
	if [ $i -eq 1 ]; then
		echo " filed 1 will be the primary key."
		while true ;
	       	do	
			read -r -p "enter the name of the primary key: " pk_name
			if validate_fileds "$pk_name"; then
				
				echo "now choose the data type for primary key: "
				select opt in INT VARCHAR
				do
					case $opt in 
						"INT")
							dt_pk_n="$opt"
							echo "you choose datatypr INT"
							break
							;;
						"VARCHAR")
							dt_pk_n="$opt"
							echo "you chose datatype VARCHAR"
							break
							;;
						*)
							echo " invalied options!!"
					esac
				done
				echo "Field $i: $pk_name (Primary Key, '$dt_pk_n') " >> "$s_table_name"
				echo "field number $i is stored in metadata file corcctly"
				break
			else
				echo "enter a valied field"
			fi

		done
	else
		while true ;
	       	do	
			read -r -p "enter field number $i: " field
			if validate_fileds "$field"; then
				
				echo "now choose the data type for field number $i: "
				select opt in INT VARCHAR
				do
					case $opt in 
						"INT")
							field_type="$opt"
							echo "you choose datatypr INT"
							break
							;;
						"VARCHAR")
							field_type="$opt"
							echo "you chose datatype VARCHAR"
							break
							;;
						*)
							echo " invalied options!!"
					esac
				done
			fi
				echo "Field $i: $field ('$field_type') " >> "$s_table_name"
				echo "field number $i is stored in metadata file corcctly"
				break
		
		done

	fi	
done
