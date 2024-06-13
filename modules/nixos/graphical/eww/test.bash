#! /bin/sh
xprop -spy -root _NET_CURRENT_DESKTOP _NET_DESKTOP_NAMES | while read -r line; do
	if [[ $line == *"CURRENT"* ]]
	then
		current=$(echo "$line" | cut -d"=" -f2)
	else
		names=$(echo "$line" | cut -d"=" -f2 | sed 's#[",]##g')
	fi
	printf "["
	counter=0;
	for desktop in $names
	do 
		if [[ $counter -gt 0 ]]
		then
			printf ","
		fi

		printf "{"

		if [[ $counter -eq $current ]]
		then
			printf "\"current\":true,"
		else
			printf "\"current\":false,"
		fi
		printf 
		printf "\"name\": \"%s\"}" $desktop
		((counter++)) 
	done
	printf "]\n"
done
