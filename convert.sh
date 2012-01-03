#!/bin/bash -x
#Enabling debug mode so we can see what is happening.
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
	#Comment the next line to prevent this script from renaming converted .iso files
	#to .osi. Copy/paste and execute the following comment with the # after this script
	#is done running to restore .iso extension
	#find . -iname "*.osi" | while read f; do echo mv \"$f\" \"${f/.osi/.iso}\"; done
	mv "$file" "$dir2"/"$filename".osi 
done
