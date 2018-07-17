#!/bin/bash
# Source: https://serverfault.com/questions/661978/displaying-a-remote-ssl-certificate-details-using-cli-tools @ 20170616 18:30UTC

site=$1
echo | openssl s_client -showcerts -servername $site -connect $site:443 2>/dev/null | openssl x509 -inform pem -noout -text

