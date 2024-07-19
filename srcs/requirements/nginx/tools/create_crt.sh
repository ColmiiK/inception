#!/bin/bash

if [ ! -f "srcs/requirements/nginx/tools/alvega-g.42.fr.crt" ]; then
	openssl genpkey -algorithm RSA -out alvega-g.42.fr.key -pkeyopt rsa_keygen_bits:4096
	openssl req -new -key alvega-g.42.fr.key -out alvega-g.42.fr.csr -sha256 -subj "/C=ES/ST=Malaga/L=Malaga/O=42School/OU=42Malaga/C    N=www.alvega-g.42.fr"
	openssl x509 -req -in alvega-g.42.fr.csr -signkey alvega-g.42.fr.key -out alvega-g.42.fr.crt -days 365 -sha256
	mv alvega-g.42.fr.key srcs/requirements/nginx/tools
	mv alvega-g.42.fr.crt srcs/requirements/nginx/tools
	rm alvega-g.42.fr.csr
fi
