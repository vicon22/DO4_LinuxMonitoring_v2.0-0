#!/bin/bash
. ./brain.sh
. ./check.sh

export count_var=${#}
export path=${1}
export count_dirs=${2}
export letters_dirs=${3}
export count_files=${4}
export letters_files=${5}
export size=${6}

check
createNameForDirs
