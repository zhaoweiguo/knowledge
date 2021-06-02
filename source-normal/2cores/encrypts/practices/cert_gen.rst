自动创建证书请求
################

ecc 算法证书请求::

  #!/bin/sh
   
  `openssl ecparam -out private.pem -name secp384r1 -genkey `
   
  if [[ "$1" = ""  || "$2" = ""  || "$3" = "" || "$4" = "" || "$5" = "" || "$6" = "" || "$7" = "" ]] ; then
    echo "certRequestCreate.sh  country state location organization organizationUnit commonName  email"  
    exit 0;
  else
    if [ "$8" = "" ] ; then 
      `openssl req -new -key private.pem -passin pass:123456  -subj /C=$1/ST=$2/L=$3/O=$4/OU=$5/CN=$6/emailAddress=$7    -out client.pem `
    else  
      sed -i '/\[SAN\]*/d' /etc/pki/tls/openssl.cnf
      sed -i '/subjectAltName*/d' /etc/pki/tls/openssl.cnf
      `echo "[SAN]" >> /etc/pki/tls/openssl.cnf `
      `echo "subjectAltName=DNS:$8" >> /etc/pki/tls/openssl.cnf `
      `openssl req -new -key private.pem -passin pass:123456 -subj /C=$1/ST=$2/L=$3/O=$4/OU=$5/CN=$6/emailAddress=$7 -reqexts SAN -config  /etc/pki/tls/openssl.cnf  -out client.pem `
      sed -i '/\[SAN\]*/d' /etc/pki/tls/openssl.cnf
      sed -i '/subjectAltName*/d' /etc/pki/tls/openssl.cnf
    fi
  fi


rsa 算法证书请求::


  #!/bin/sh
   
  `openssl genrsa   -out private.pem 2048`
   
   
   
   
  if [[ "$1" = ""  || "$2" = ""  || "$3" = "" || "$4" = "" || "$5" = "" || "$6" = "" || "$7" = "" ]] ; then
    echo "certRequestCreate.sh  country state location organization organizationUnit commonName  email"  
    exit 0;
  else
    if [ "$8" = "" ] ; then 
      `openssl req -new -key private.pem -passin pass:123456  -subj /C=$1/ST=$2/L=$3/O=$4/OU=$5/CN=$6/emailAddress=$7   -extensions v3_ca -out client.pem `
    else  
      sed -i '/\[SAN\]*/d' /etc/pki/tls/openssl.cnf
      sed -i '/subjectAltName*/d' /etc/pki/tls/openssl.cnf
      `echo "[SAN]" >> /etc/pki/tls/openssl.cnf `
      `echo "subjectAltName=DNS:$8" >> /etc/pki/tls/openssl.cnf `
      `openssl req -new -key private.pem -passin pass:123456  -subj /C=$1/ST=$2/L=$3/O=$4/OU=$5/CN=$6/emailAddress=$7 -extensions v3_ca -reqexts SAN -config  /etc/pki/tls/openssl.cnf  -out client.pem `
      sed -i '/\[SAN\]*/d' /etc/pki/tls/openssl.cnf
      sed -i '/subjectAltName*/d' /etc/pki/tls/openssl.cnf
    fi
  fi
