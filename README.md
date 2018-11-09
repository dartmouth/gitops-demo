# Set up NGINX
* Create a self-signed certificate
* Build an NGINX image
* TODO: add steps for getting openssl
* TODO: add steps for getting Docker installed by linking to Docker URL

``` shell
openssl genrsa -out ca.key 2048
openssl req -new -x509 -days 365 -key ca.key -subj "/C=US/ST=NH/L=Hanover/O=Dartmouth College/CN=Localhost Root CA" -out ca.crt

openssl req -newkey rsa:2048 -nodes -keyout dockerdemo_tld.key -subj "/C=US/ST=NH/L=Hanover/O=Dartmouth College/CN=*.dockerdemo.tld" -out dockerdemo_tld.csr
openssl x509 -req -days 3650 -in dockerdemo_tld.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out dockerdemo_tld.crt
```

``` shell
Import-Certificate -FilePath $pwd\ca.crt -CertStoreLocation "cert:\CurrentUser\Root"
```

``` shell
$ConfigRoot = "$pwd\volumes\nginx"

mkdir $Configroot
docker network create docker-local-demo

docker run -d `
--name nginx `
--network=docker-local-demo `
--restart unless-stopped `
-p 80:80 `
-p 443:443 `
-v $ConfigRoot\nginx.conf:/etc/nginx/nginx.conf:ro `
-v $ConfigRoot\dockerdemo_tld.crt:/etc/nginx/dockerdemo_tld.crt:ro `
-v $ConfigRoot\dockerdemo_tld.key:/etc/nginx/dockerdemo_tld.key:ro `
nginx
```

* TODO: make gitignore file

# Jenkins

# GIT

