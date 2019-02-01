#!/bin/sh
 
 
 
set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace
 
 
 
# Testing functions for structure file and content folder
structure_check () {
if [[ ! -f "${structure}" ]]; then
    echo "Error: Structure file not found!"
    exit
fi
    }
 
content_check () {
if [[ ! -d "${content}" ]]; then
    echo "Error: Content folder not found!"
    exit
fi
    }
 
# Default paths for project structure
structure="/etc/scriptbuilder/default/structure"
content="/etc/scriptbuilder/default/contents"
 
 
verbose=""
debug="false"
# Flags and argument processing
while getopts "xvp:c:d:s:" opt; do
    case $opt in
        s)  
            structure="${OPTARG}"
            structure_check
            ;;
        d)
            content="${OPTARG}"
            content_check
            ;;
        c)
            if [[ ! -d "${OPTARG}" ]]; then
                echo "Error: Argument is not a directory"
                exit
            fi
            structure_check
            content_check
            diff -rq "${OPTARG}" "${content}"
            exit 1
            ;;
        p)
            FILE=${OPTARG}
            if [[ ! -f "${FILE}" ]]; then
                echo "Error: Argument is not a file!"
                exit 1
            fi
            ls -l ${content} | egrep '^d' | awk '{print $9}' > ${FILE}
            exit 1
            ;;
        v)
            verbose="true"
            ;;
        x)
            debug="true"
            verbose="true"
            ;;
        /?)        
            echo "Error: invalid option -${OPTARG}" >&2
            exit 1
            ;;
        :)
            echo "Error: option -${OPTARG} requires an argument" >&2
            exit 1
            ;;
    esac
done
 
 
 
if [[ "${debug}" = "false" ]]; then
    echo "Enter the project name"
    read name
fi
 
[[ "$verbose" == "true" ]] && echo "Reading the name..." && sleep 2  
[[ "$verbose" == "true" ]] && echo "Checking if such name already used..." && sleep 2
 
if [[ "${debug}" = "false" ]]; then
    while [[ -d "${name}" ]]; do
    name="debug"
    echo "Directory with this name already exists, please enter different name"
    read name
    done
fi
 
[[ "$verbose" == "true" ]] && echo "Checking the structure file and content folder..." && sleep 2
 
structure_check
content_check
 
[[ "$verbose" == "true" ]] && echo "Reading the structure file and creating directories..." && sleep 2
 
if [[ "${debug}" = "false" ]]; then
    while IFS="" read -r p || [[ -n "$p" ]]
    do
        mkdir -p "${name}"/"${p}"
    done < ${structure}
fi
 
[[ "$verbose" == "true" ]] && echo "Picking up the directories names from project folder and content folder..." && sleep 2
 
if [[ "${debug}" = "false" ]]; then
    DIRS=`ls -l $name | egrep '^d' | awk '{print $9}'`  
    CONTENTS=`ls -l $content | egrep '^d' | awk '{print $9}'`
fi
 
   
[[ "$verbose" == "true" ]] && echo "Comparing the names of directories and copying the files if they match..." && sleep 2
 
if [[ "${debug}" = "false" ]]; then
    for DIR in ${DIRS}
        do
            for CONT in ${CONTENTS}
                do
                    if [[ "${DIR}" == "${CONT}" ]]; then
                        cp -R "${content}"/"${CONT}"/. "${name}"/"${DIR}"/
                    fi
                done
        done
fi
 
[ "$verbose" == "true" ] && echo "Finishing..." && sleep 1

