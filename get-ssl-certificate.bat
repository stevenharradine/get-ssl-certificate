@echo off
REM Source: https://serverfault.com/questions/661978/displaying-a-remote-ssl-certificate-details-using-cli-tools @ 20170616 18:30UTC

set site=%1
openssl s_client -showcerts -servername %site% -connect %site%:443 2> NUL | openssl x509 -inform pem -noout -text
