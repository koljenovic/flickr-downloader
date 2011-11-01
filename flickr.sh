#!/usr/bin/env bash

## pic sizes
## s; t; m; z; b; o

url=${1}
page=${2}
size=${3}
count=1

until [[ "${count}" -gt "${page}" ]]; do
	echo "Parsing page ${count} of ${page} …"
	html=${html}$(wget -qO- "${url}?page=${count}")
	((count+=1))
done

echo "Generating Linklist … (this may take a while)"
arr_links=($(wget -qO- $(echo "${html}" | egrep -o 'photos.+/in/set-[0-9]+' | sed 's%photos%http:\/\/www.flickr.com\/photos%') \
| egrep -o "'http://.+_${size}.jpg'" | sed "s%'%%g"))

echo "Downloading ${#arr_links[@]} Pictures. Doubles might be ignored."
wget -nc ${arr_links[@]}
