#!/bin/bash

function createNameForDirs {
    touch log.txt
    for (( number=0; number <$count_dirs; number++ ))
    do
        dir_name=""
        create_dir
        create_files
    done
}

function create_dir {
    dir_name=$(create_unique_name)
    mkdir $dir_name
    echo $path"/"$dir_name --- $(date +'%e.%m.%Y') ---  >> log.txt
}

function create_unique_name {
    unique_name = "";
    count=${#letters_dirs}
    for (( i2=0; i2<5-count; i2++ ))
    do
        unique_name+="$(echo ${letters_dirs:0:1})"
    done
    for (( i=0; i<count; i++ ))
    do
        dir_letter="$(echo ${letters_dirs:i:1})"
        count3=${RANDOM:0:1}
        for (( j=0; j<count3; j++ ))
        do
            unique_name+=$dir_letter
        done
    done
        unique_name+="_"
        unique_name+=$(date +"%d%m%y")
        echo "$unique_name"
}

function create_files {
    file_name_start="$(echo $letters_files | awk -F "." '{print $1}')"
    file_name_end="$(echo $letters_files | awk -F "." '{print $2}')"
    for (( number_files=0; number_files <$count_files; number_files++ ))
    do
        file_name=""
        if [[ ${#file_name_start} -lt 4 ]]
        then
            create_files_with_little_name
        else
            create_files_with_big_name
        fi
        echo $path"/"$dir_name"/"$file_name --- $(date +'%e.%m.%Y') --- $size "Kb"
        echo $path"/"$dir_name"/"$file_name --- $(date +'%e.%m.%Y') --- $size "Kb" >> log.txt
    done
}

function create_files_with_little_name {
    count=${#file_name_start}
    for (( i=0; i<5-count; i++ ))
    do
        file_name+="$(echo ${file_name_start:0:1})"
    done
    file_name+="$(echo ${file_name_start:1:${#file_name_start}})"
    file_name+=$number_files
    file_name+="_"
    file_name+=$(date +"%d%m%y")
    file_name+="."
    file_name+=$file_name_end
    touch ./$dir_name/$file_name
    if [[ $(df -m | head -n2 | tail -n1 | awk -F" " '{print $4}') -le 1024 ]]
    then
        echo 'Less than 1GB memory'
        exit 1
    fi
}

function unique_filename {
    count=${#file_name_start}
    for (( i=0; i<5-count; i++ ))
    do
        file_name+="$(echo ${file_name_start:0:1})"
    done
    
    file_name+="_"
    file_name+=$(date +"%d%m%y")
    file_name+="."
    file_name+=$file_name_end
    touch ./$dir_name/$file_name
    if [[ $(df -m | head -n2 | tail -n1 | awk -F" " '{print $4}') -le 1024 ]]
    then
        echo 'Less than 1GB memory'
        exit 1
    fi
}
