#!/bin/bash
# Script file : syracuse.bash
# MUNOZ Melvyn, CAUSSE Raphael
# CY TECH PREING 2 MI

function usage() {
    echo -e "\e[1mUsage:\e[0m\t$0 [start] [end]\n"
    echo -e "\t[start]  Strictly positive integer."
    echo -e "\t[end]    Strictly positive integer."
    echo -e "\n\e[1mOption:\e[0m $0 [-h|--help]\n"
    echo -e "\t-h, --help"
    echo -e "\t\t Print this help message and exit."
    exit 0
}

function error_args() {
    echo -e "\e[1m\e[31mError:\e[0m unvalid arguments:"
    echo "Run « ./syracuse -h » or « ./syracuse --help » for more information."
    exit 1
}

# Check for valid number of arguments
if [ $# -eq 0 ] || [ $# -gt 2 ]; then
    error_args
elif [ $# -eq 1 ] && [ $1 == "-h" ] || [ $1 == "--help" ]; then
    usage
fi

# Check for valid arguments, 2 strictly positive integers
if [ $# -eq 2 ] && [[ $1 =~ ^[1-9]+[0-9]*$ ]] && [[ $2 =~ ^[1-9]+[0-9]*$ ]]; then
    # Compile and execute C prog
    gcc -O3 main.c -o syracuse
    syrac_cprog="./syracuse"
    mkdir -p Data Images
    for ((i=$1; i<=$2; i++)); do
        ${syrac_cprog} ${i} Data/f${i}.dat
    done
    # Collect data from files and analyze them
    ls -1v Data/
    # Gnuplot usage
    
else
    error_args
fi