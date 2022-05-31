#!/bin/bash
# Source: https://serverfault.com/questions/661978/displaying-a-remote-ssl-certificate-details-using-cli-tools @ 20170616 18:30UTC

showHelp=false
hideAll=false
showVersion=false
showSerialNumber=false
showSignatureAlgorithm=false
showIssuer=false
showValidity=false
showSubject=false

for arg in "$@"; do
	key=`echo "$arg" | awk -F "=" '{print $1}'`
	value=`echo "$arg" | awk -F "=" '{print $2}'`

	if [[ $key == "-?" ]] || [[ $key == "-h" ]] || [[ $key == "--help" ]]; then
		showHelp=true
	elif [[ $key == "--hide-all" ]] || [[ $key == "+noall" ]]; then
		hideAll=true
	elif [[ $key == "--show-version" ]] || [[ $key == "+version" ]]; then
		showVersion=true
	elif [[ $key == "--show-serialNumber" ]] || [[ $key == "+serialNumber" ]]; then
		showSerialNumber=true
	elif [[ $key == "--show-signatureAlgorithm" ]] || [[ $key == "+signatureAlgorithm" ]]; then
		showSignatureAlgorithm=true
	elif [[ $key == "--show-issuer" ]] || [[ $key == "+issuer" ]]; then
		showIssuer=true
	elif [[ $key == "--show-validity" ]] || [[ $key == "+validity" ]]; then
		showValidity=true
	elif [[ $key == "--show-subject" ]] || [[ $key == "+subject" ]]; then
		showSubject=true
	fi
done

if [[ $showHelp == true ]]; then
	echo "Usage:  get-ssl-certificate [domain] [arguments]"
	echo "Where:  domain      is in the Domain Name System"
	echo "        arguments   is one or more of:"
	echo "                     --hide-all, +noall                               hide the whole certificate results, use in conjection with one of the show options"
	echo "                     --show-version, +version                         show version"
	echo "                     --show-serialNumber, +serialNumber               show serial number"
	echo "                     --show-signatureAlgorithm, +signatureAlgorithm   show signature algorithm"
	echo "                     --show-issuer, +issuer                           show issuer"
	echo "                     --show-validity, +validity                       show validity"
	echo "                     --show-subject, +subject                         show subject"
	echo "                     --show-help, -?, -h                              Show this help menu and exit"

	exit 0;
fi

site=$1
buffer=`echo | openssl s_client -showcerts -servername $site -connect $site:443 2>/dev/null | openssl x509 -inform pem -noout -text`
whiteSpaceConstant="        "

if [ $hideAll == false ]; then
	echo "$buffer"
else
	if [ $showVersion == true ]; then
		echo "$buffer" | grep "$whiteSpaceConstant""Version:"
	fi
	if [ $showSerialNumber == true ]; then
		echo "$buffer" | grep -A 1 "$whiteSpaceConstant""Serial Number:" | tail -n 1
	fi
	if [ $showSignatureAlgorithm == true ]; then
		echo "$buffer" | grep "$whiteSpaceConstant""Signature Algorithm:"
	fi
	if [ $showIssuer == true ]; then
		echo "$buffer" | grep "$whiteSpaceConstant""Issuer:"
	fi
	if [ $showValidity == true ]; then
		echo "$buffer" | grep -A 2 "$whiteSpaceConstant""Validity" | tail -n 2
	fi
	if [ $showSubject == true ]; then
		echo "$buffer" | grep "$whiteSpaceConstant""Subject:"
	fi
fi
