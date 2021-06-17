证书生成注意三点

第一点，注意将其中的私钥加密密码（-passout参数）修改成自己的密码；下边都是以带-passout参数生成私钥，如果不使用-passout参数，则最后一步“将加密的RSA密钥转成未加密的RSA密钥”不需要执行。

第二点，证书和密钥给出了直接一步生成和分步生成两种形式，两种形式是等价的，这里使用直接生成形式（分步生成形式被注释）

第三点，注意将其中的证书信息改成自己的组织信息的。其中证数各参数含义如下：

C-----国家（Country Name）

ST----省份（State or Province Name）

L----城市（Locality Name）

O----公司（Organization Name）

OU----部门（Organizational Unit Name）

CN----产品名（Common Name）

emailAddress----邮箱（Email Address）

# CA证书及密钥生成方法一----直接生成CA密钥及其自签名证书
# 如果想以后读取私钥文件ca_key.pem时不需要输入密码，亦即不对私钥进行加密存储，那么将-passout pass:123456删掉
openssl req -newkey rsa:2048 -passout pass:123456 -keyout ca_key.pem -x509 -days 365 -out ca.crt -subj "/C=CN/ST=GD/L=SZ/O=COM/OU=NSP/CN=CA/emailAddress=youremail@qq.com"
# CA证书及密钥生成方法二----分步生成CA密钥及其自签名证书：
# openssl genrsa  -passout pass:123456 -out ca_key.pem 2048
# openssl req -new -x509 -days 365 -key ca_key.pem -out ca.crt -subj "/C=CN/ST=GD/L=SZ/O=COM/OU=NSP/CN=CA/emailAddress=youremail@qq.com"

# 服务器证书及密钥生成方法一----直接生成服务器密钥及待签名证书
# 如果想以后读取私钥文件server_key.pem时不需要输入密码，亦即不对私钥进行加密存储，那么将-passout pass:server删掉
openssl req -newkey rsa:2048 -passout pass:server -keyout server_key.pem  -out server.csr -subj "/C=CN/ST=GD/L=SZ/O=COM/OU=NSP/CN=SERVER/emailAddress=youremail@qq.com"
# 服务器证书及密钥生成方法二----分步生成服务器密钥及待签名证书
# openssl genrsa  -passout pass:server -out server_key.pem 2048
# openssl req -new -key server_key.pem -passin pass:server -out server.csr -subj "/C=CN/ST=GD/L=SZ/O=COM/OU=NSP/CN=SERVER/emailAddress=youremail@qq.com"
# 使用CA证书及密钥对服务器证书进行签名：
openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca_key.pem -passin pass:123456 -CAcreateserial -out server.crt
# 将加密的RSA密钥转成未加密的RSA密钥，避免每次读取都要求输入解密密码
# 密码就是生成私钥文件时设置的passout、读取私钥文件时要输入的passin，比如这里要输入“server”
openssl rsa -in server_key.pem -out server_key.pem.unsecure

# 客户端证书及密钥生成方法一----直接生成客户端密钥及待签名证书
# 如果想以后读取私钥文件client_key.pem时不需要输入密码，亦即不对私钥进行加密存储，那么将-passout pass:client删掉
openssl req -newkey rsa:2048 -passout pass:client -keyout client_key.pem -out client.csr -subj "/C=CN/ST=GD/L=SZ/O=COM/OU=NSP/CN=CLIENT/emailAddress=youremail@qq.com"
# 客户端证书及密钥生成方法二----分步生成客户端密钥及待签名证书：
# openssl genrsa  -passout pass:client -out client_key.pem 2048
# openssl req -new -key client_key.pem -passin pass:client -out client.csr -subj "/C=CN/ST=GD/L=SZ/O=COM/OU=NSP/CN=CLIENT/emailAddress=youremail@qq.com"
# 使用CA证书及密钥对客户端证书进行签名：
openssl x509 -req -days 365 -in client.csr -CA ca.crt -CAkey ca_key.pem -passin pass:123456 -CAcreateserial -out client.crt
# 将加密的RSA密钥转成未加密的RSA密钥，避免每次读取都要求输入解密密码
# 密码就是生成私钥文件时设置的passout、读取私钥文件时要输入的passin，比如这里要输入“client”
openssl rsa -in client_key.pem -out client_key.pem.unsecure



也可直接使用以下脚本生成证书以及秘钥：

#
# Generate the certificates and keys for testing.
#


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

mkdir ca
mkdir server
mkdir client

# private key generation
openssl genrsa -out ca.key 1024
openssl genrsa -out server.key 1024
openssl genrsa -out client.key 1024

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


mv ca.crt ca.key ca/
mv server.crt server.key server/
mv client.crt client.key client/

rm *.conf
rm *.req
rm *.srl 
