#!/bin/bash
find . -iname "*.iso" | while read file
do
	#Print second field because results start with ./<dir>/...
	dir=`echo "$file" | awk -F/ '{print $2}'`
	dir2=`dirname -- "$file"`
	if [ -d "$dir" ]; then
		filename=`echo "$file" | awk -F/ '{print $NF}' | sed 's/.\{4\}$//'`
         fi
	mkdir /path/to/converted_movies/"$dir"
	HandBrakeCLI -v --preset="High Profile" -i "$file" -o /path/to/converted_movies/"$dir"/"$filename".mp4 -f mp4 -O --main-feature -m -B 160,440 -s 1,2,3,4,5,6,7,8,9 < /dev/null 2> /path/to/converted_movies/"$dir"/log.txt
	mv "$file" "$dir2"/"$filename".osi 
done
