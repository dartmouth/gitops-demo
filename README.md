# Set up NGINX
* Create a self-signed certificate
* Build an NGINX image
* TODO: add steps for getting openssl
* TODO: add steps for getting Docker installed by linking to Docker URL

``` shell
openssl genrsa -out ca.key 2048
openssl req -new -x509 -days 365 -key ca.key -subj "/C=US/ST=NH/L=Hanover/O=Dartmouth College/CN=Localhost Root CA" -out ca.crt

openssl req -newkey rsa:2048 -nodes -keyout docker-demo_edu.key -subj "/C=US/ST=NH/L=Hanover/O=Dartmouth College/CN=*.docker-demo.edu" -out docker-demo_edu.csr





$Request = @"
[req]
prompt                      = no
default_bits                = 2048
distinguished_name          = req_distinguished_name
req_extensions              = req_ext
[req_distinguished_name]
C                           = US
ST                          = New Hampshire
L                           = Hanover
O                           = Dartmouth College
CN                          = docker-demo.edu
[req_ext]
subjectAltName = @alt_names
[alt_names]
DNS.1 = docker-demo.edu
DNS.2 = *.docker-demo.edu
"@ | Out-File "$pwd\docker-demo.cnf"

# Create the CSR and private key
openssl req -newkey rsa:2048 -nodes -config "$pwd\docker-demo.cnf" -out "$pwd\docker-demo.csr" -keyout "$pwd\docker-demo.key"
openssl x509 -req -days 3650 -in docker-demo.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out docker-demo.crt
```



``` shell
Import-Certificate -FilePath $pwd\ca.crt -CertStoreLocation "cert:\CurrentUser\Root"
```

``` shell
$ConfigRoot = "$pwd\volumes\nginx"

mkdir $Configroot
docker network create docker-local-demo


cp docker-demo_edu.crt volumes\nginx
cp docker-demo_edu.key volumes\nginx
cp .\nginx.conf .\volumes\nginx\



docker run -d `
--name nginx `
--network=docker-local-demo `
--restart unless-stopped `
-p 80:80 `
-p 443:443 `
-v $ConfigRoot\nginx.conf:/etc/nginx/nginx.conf:ro `
-v $ConfigRoot\docker-demo.crt:/etc/nginx/docker-demo.crt:ro `
-v $ConfigRoot\docker-demo.key:/etc/nginx/docker-demo.key:ro `
nginx
```

* Add site to hostfile

``` shell
"127.0.0.1  docker-demo.edu" >> C:\Windows\System32\drivers\etc\hosts
"127.0.0.1  portal.docker-demo.edu" >> C:\Windows\System32\drivers\etc\hosts
"127.0.0.1  git.docker-demo.edu" >> C:\Windows\System32\drivers\etc\hosts
"127.0.0.1  ci.docker-demo.edu" >> C:\Windows\System32\drivers\etc\hosts
"127.0.0.1  www.docker-demo.edu" >> C:\Windows\System32\drivers\etc\hosts
```

* TODO: make gitignore file

# Jenkins

# GIT

