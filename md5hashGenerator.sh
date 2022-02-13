#!/bin/bash

# Constantes para facilitar a utilização das cores.
GREEN='\033[32;1m'
YELLOW='\033[33;1m'
BLUE='\033[34;1m'
RED='\033[31;1m'
RED_BLINK='\033[31;5;1m'
END='\033[m'

# Função chamada quando cancelar o programa com [Ctrl]+[c]
trap __Ctrl_c__ INT

__Ctrl_c__() {
   # __Clear__
    printf "\n${RED_BLINK} [!] Ação abortada!${END}\n\n"
    exit 1
}

if [ "$1" == "" ] && [ "$2" == "" ]
then
	echo " "
	toilet -f future " MD5 HASH GENERATOR"
	echo " "
	echo -e "${BLUE} [*] Generate MD5 HASH from wordlist lines${END}"
	echo -e "${GREEN}     Example: $0 wordlist.txt${END}"
	echo " "
	echo -e "${BLUE} [*] Compare MD5 HASH with wordlist lines${END}"
	echo -e "${GREEN}     Example: $0 wordlist.txt 4e76434eea3c9d9cf9cb10bbf3f4a74b${END}"
	echo " "
	exit
fi
if [ "$2" == "" ]
then
	echo " "
	echo -e "${BLUE} [*] Generating MD5 HASH of wordlist lines...${END}"
	echo " "
	for linha in $(cat $1);
	do
		echo -n "$linha" | md5sum | sed "s/  -/ - $linha/";
	done;
fi
if [ "$1" != "" ] && [ "$2" != "" ]
then
	for linha in $(cat $1);
	do
		hash=$(echo -n "$linha" | md5sum | sed "s/  -//");
		if [ "$hash" == "$2" ]
		then
			clear
			echo " "
			echo -e "${BLUE} [*] Comparing the MD5 HASH of the argument with the MD5 HASH of the wordlist lines...${END}"
			echo " "
			echo -e "${GREEN} [+] Hash found: ${END}"
			echo -n "$linha" | md5sum | sed "s/  -/ - $linha/"
			echo " "
			exit
		fi
		if [ "$hash" != "$2" ]
		then
			clear
			echo " "
			echo -e "${BLUE} [*] Comparing the MD5 HASH of the argument with the MD5 HASH of the wordlist lines...${END}"
			echo " "
			echo -e "${YELLOW} [!] Trying...${END}"
			echo -n "$linha" | md5sum | sed "s/  -/ - $linha/"
		fi
	done;
clear
echo " "
echo -e "${BLUE} [*] Comparing the MD5 HASH of the argument with the MD5 HASH of the wordlist lines...${END}"
echo " "
echo -e "${RED} [!] Not found.${END}"
exit
fi
