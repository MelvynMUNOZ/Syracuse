#!/bin/bash
# Script file : syracuse.bash
# MUNOZ Melvyn, CAUSSE Raphael
# CY TECH PREING 2 MI

function usage {
    echo -e "\e[1mUsage:\e[0m\t$0 [start] [end]\n"
    echo -e "\t[start]  Strictly positive integer."
    echo -e "\t[end]    Strictly positive integer."
    echo -e "\n\e[1mOption:\e[0m $0 [-h|--help]\n"
    echo -e "\t-h, --help"
    echo -e "\t\t Print this help message and exit."
    exit 0
}

function error_args {
    echo -e "\e[1m\e[31mError:\e[0m unvalid arguments:"
    echo "Run « ./syracuse -h » or « ./syracuse --help » for more information."
    exit 1
}

# $1    data file to collect data
# $2    data file to receive data
function collect_all_seq_data {
    head -n-3 $1 | tail -n+2 >> $2
}
function collect_alti_max {
    tail -n3 $1 | head -n1 | cut -d'=' -f2 >> $2
}
function collect_flight_time {
    tail -n2 $1 | head -n1 | cut -d'=' -f2 >> $2
}
function collect_alti_time {
    tail -n1 $1 | cut -d'=' -f2 >> $2
}

# Check for valid number of arguments
if [ $# -eq 0 ] || [ $# -gt 2 ]; then
    error_args
elif [ $# -eq 1 ] && [ $1 == "-h" ] || [ $1 == "--help" ]; then
    usage
fi

# Check for valid arguments, 2 strictly positive integers
if [ $# -eq 2 ] && [[ $1 =~ ^[1-9]+[0-9]*$ ]] && [[ $2 =~ ^[1-9]+[0-9]*$ ]]; then
    # Create subdirectories to store data, and temporary data files
    mkdir -p Data Images && touch seq_data alti_max flight_time alti_time
    # Compile and execute C prog
    gcc -O3 main.c -o syracuse
    syrac_cprog="./syracuse"
    for ((i=$1; i<=$2; i++)); do
        ${syrac_cprog} ${i} Data/f${i}.dat
        # Collect data in temporary files
        collect_all_seq_data Data/f${i}.dat seq_data
        collect_alti_max Data/f${i}.dat alti_max
        collect_flight_time Data/f${i}.dat flight_time
        collect_alti_time Data/f${i}.dat alti_time
    done
    # Analyze data with Gnuplot

    
    # Remove temporary data files
    rm Data/* && rm seq_data alti_max flight_time alti_time
else
    error_args
fi