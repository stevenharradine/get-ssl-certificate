# get-ssl-certificate
Downloads and displays a sites SSL certificate.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Usage
### *nix
```
./get-ssl-certificate.sh {{ domain }} {{arguments}}
```
### Windows
this is 100% an afterthought of the main program for *nix, youve been warned.  This is now behind in development and has no arguments.
```
get-ssl-certificate.bat {{ domain }}
```
### Where,
 * `domain` the domain of the SSL certificate to view
 * `arguments`   is one or more of:
```
     --hide-all, +noall                               hide the whole certificate results, use in conjection with one of the show options
     --show-version, +version                         show version
     --show-serialNumber, +serialNumber               show serial number
     --show-signatureAlgorithm, +signatureAlgorithm   show signature algorithm
     --show-issuer, +issuer                           show issuer
     --show-validity, +validity                       show validity
     --show-subject, +subject                         show subject
     --show-help, -?, -h                              Show this help menu and exit
```
