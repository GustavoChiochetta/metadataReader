#!/bin/bash

echo "Metada Reader by _Gh0st_"

if [ "$1" == "" ]
then
    echo "usage: $0 example.com"
else
    mkdir files/$1
    echo "looking for pdf files in $1"
    lynx --dump "https://google.com/search?&q=site:$1+ext:pdf" | grep ".pdf" | cut -d "=" -f2 | egrep -v "site|google" | sed 's/...$//' >> files/$1/$1.txt
    for url in $(cat files/$1/$1.txt); do
        echo "downloading $url"
        wget -q --directory-prefix=files/$1 $url
    done

    echo "Reading metadata from files"

    exiftool files/$1/*.pdf
fi
