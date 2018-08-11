DOCKER_IMAGE_NAME   ?= danguita/shell
DOCKER_IMAGE_TAG    ?= latest
DOCKER_IMAGE        := $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)
DOCKER_REGISTRY_URL ?= docker.io

USER_HOME := /root

DOCKER_BUILD := docker build --file Dockerfile
DOCKER_PUSH  := docker push
DOCKER_TAG   := docker tag

DOCKER_RUN   := docker run -it --rm --net=host \
	-v "$(PWD):/workspace" \
	-v "$(HOME)/.ssh:$(USER_HOME)/.ssh" \
	-v "$(HOME)/.gnupg:$(USER_HOME)/.gnupg" \
	-v "$(HOME)/.gitconfig:$(USER_HOME)/.gitconfig"

CACHEBUST_ARG := CACHEBUST=$(shell date +%s)

.PHONY: build
build: Dockerfile
	$(DOCKER_BUILD) --tag $(DOCKER_IMAGE) --build-arg $(CACHEBUST_ARG) .

.PHONY: clean_build
clean_build: Dockerfile
	$(DOCKER_BUILD) --no-cache --tag $(DOCKER_IMAGE) --build-arg $(CACHEBUST_ARG) .

.PHONY: run
run:
	$(DOCKER_RUN) $(DOCKER_IMAGE)

.PHONY: release
release:
	$(DOCKER_TAG) $(DOCKER_IMAGE) $(DOCKER_REGISTRY_URL)/$(DOCKER_IMAGE)
	$(DOCKER_PUSH) $(DOCKER_REGISTRY_URL)/$(DOCKER_IMAGE)
