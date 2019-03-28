
build:
	docker build . -t docker.bulogics.com/docker-jre:zulu11.0.2_alpine_3.9.2_02

push:
	docker push docker.bulogics.com/docker-jre:zulu11.0.2_alpine_3.9.2_02