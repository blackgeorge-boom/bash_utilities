#!/usr/bin/env bash

corpus_dir=~/Desktop/AD
cd ${corpus_dir}
find -name "* *" -type f | rename 's/ /_/g'

for file in *.txt; do

    [ -e "$file" ] || continue

    cmd="file -i ${file}"
    result=$(${cmd})
    #echo ${result}

    charset=$(echo ${result} | cut -d ' ' -f 3-)
    encoding=${charset:8}
    echo ${encoding}

    name=${file##*/}
    base=${name%.txt}

	old=${name}
	new=${base}"_new.txt"
	#echo ${old}
	#echo ${new}

    if [ "${encoding}" = "unknown-8bit" ]; then
	    iconv -f ISO-8859-7 -t UTF-8 ${old} > ${new}
	    echo '1'
	elif [ "${encoding}" = "utf-8" ]; then
	    mv ${old} ${new}
	    echo '2'
    else
	    iconv -f ISO-8859-7 -t UTF-8 ${old} > ${new}
	    echo '3'
	fi
	echo

done
