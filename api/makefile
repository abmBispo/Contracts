.PHONY: all login build tag push deploy

AWS_ENDPOINT=867160744824.dkr.ecr.sa-east-1.amazonaws.com
APP=$(AWS_ENDPOINT)/contracts

all: login build tag push deploy

login:
	aws ecr get-login-password --region sa-east-1 | sudo docker login --username AWS --password-stdin $(AWS_ENDPOINT)

build:
	MIX_ENV=$(MIX_ENV) sudo docker build -t $(APP) -f docker/Dockerfile .

tag:
	sudo docker tag $(APP) $(APP):latest

push:
	sudo docker push $(APP):latest

deploy:
	eb deploy Contracts-env
