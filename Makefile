TAG=0.0.1

build:
	sed -i "s#gotafire/voota:\d+.\d+.\d+#gotafire/voota:${TAG}#g" docker-compose.yaml
	docker build --tag gotafire/voota:${TAG} -f Dockerfile .
	docker push gotafire/voota:${TAG}
