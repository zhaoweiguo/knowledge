#!/bin/bash
#
# Generate the certificates and keys for testing.
#

rm -rf ca
rm -rf server
rm -rf client
rm -rf *.key
rm -rf *.crt
PROJECT_NAME="TLS Project"

# Generate the openssl configuration files.
cat > ca_cert.conf << EOF  
[ req ]
distinguished_name     = req_distinguished_name
prompt                 = no

[ req_distinguished_name ]
 O                      = $PROJECT_NAME Dodgy Certificate Authority
EOF

cat > server_cert.conf << EOF  
[ req ]
distinguished_name     = req_distinguished_name
prompt                 = no

[ req_distinguished_name ]
 O                      = $PROJECT_NAME
 CN                     = 192.168.111.100
EOF

cat > client_cert.conf << EOF  
[ req ]
distinguished_name     = req_distinguished_name
prompt                 = no

[ req_distinguished_name ]
 O                      = $PROJECT_NAME Device Certificate
 CN                     = 192.168.111.101
EOF

#mkdir ca
#mkdir server
#mkdir client

# private key generation
openssl genrsa -out ca.key 2048
openssl genrsa -out server.key 2048
openssl genrsa -out client.key 2048

# cert requests
openssl req -out ca.req -key ca.key -new \
            -config ./ca_cert.conf
openssl req -out server.req -key server.key -new \
            -config ./server_cert.conf 
openssl req -out client.req -key client.key -new \
            -config ./client_cert.conf 

# generate the actual certs.
openssl x509 -req -in ca.req -out ca.crt \
            -sha1 -days 5000 -signkey ca.key
openssl x509 -req -in server.req -out server.crt \
            -sha1 -CAcreateserial -days 5000 \
            -CA ca.crt -CAkey ca.key
openssl x509 -req -in client.req -out client.crt \
            -sha1 -CAcreateserial -days 5000 \
            -CA ca.crt -CAkey ca.key


#mv ca.crt ca.key ca/
#mv server.crt server.key server/
#mv client.crt client.key client/


rm *.conf
rm *.req
rm *.srl
