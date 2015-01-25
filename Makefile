IMAGE_UUID := $(shell uuidgen)
CONTAINER_UUID := $(shell uuidgen)

default: docker

docker:
	cat Dockerfile.centos7 | docker build --no-cache -t "$(IMAGE_UUID)" -
	docker run --name="$(CONTAINER_UUID)" "$(IMAGE_UUID)" /bin/bash
	docker cp $(CONTAINER_UUID):/rpmbuild/RPMS/x86_64/ .
	mv x86_64 build

clean:
	rm -rf ./build
