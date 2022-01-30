#!/bin/bash

while getopts p: flag
do
  case "${flag}" in 
    p) processName=${OPTARG};;
  esac
done

if [ -z "$processName" ]
then
  echo -e "\033[31mNo process specified. Use flag '-p' to declare process name\033[0m"
  exit
fi

pgrep $processName > cmd.txt

eval cat cmd.txt | xargs kill
statCode=$?

if [ "$statCode" == "0" ]
then
  echo -e "\033[34mSuccessfully killed process '$processName'\033[0m"
  
elif [ "$statCode" == "123"  ]
then
  echo -e "\033[2A"
  echo -e "\033[1A"
  echo -e "\033[2K"
  echo -e "\033[2A"
  echo -e "\033[31mProcess '$processName' not found \033[0m"
elif [ "$statCode" == "1"  ]
then
  echo -e "Use sudo"
fi

rm cmd.txt
