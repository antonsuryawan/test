#echoserver test
echoserver test

using git clone to copy this to local
```
git clone https://github.com/antonsuryawan/test.git
```

change into test directory
```
cd test
```

##local
build
```
make
```

run the application, will taken port ==1323==
```
./echoserver
```

curl test
```
curl http://localhost:1323/<anything-here>
```

##docker
build image
```
docker build -t echoserver .
```

run image
```
docker run -d -p 1323:1323 echoserver:latest
```

curl test
```
curl http://<ip-address-of-docker>:1323/<anything-here>
```

##terraform

###pre-requisite
- AWS IAM user has been created, *Access Key ID* and *Secret Access Key* are available
- AWS VPC has been configured
- AWS Key Pairs has been created and generated `.pem` file available on local
- docker image created above, is available on accesible repository

###put value
edit `terraform/credentials.tf` with correct above value

###deployment
```
terraform init terraform/
```
```
terraform validate terraform/
```
```
terraform plan terraform/
```
```
terraform apply -auto-approve terraform/
```

example output
```
Outputs:

antontestip = aa.bb.cc.dd
```

curl test
```
curl http://<output-of-antontestip>:1323/<anything-here>
```

