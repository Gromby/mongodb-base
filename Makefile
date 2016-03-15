# Makefile for the Docker image gromby/mongodb-base
# MAINTAINER: Gromby Devops <devops@gromby.com>

.PHONY: all build release cleanup

IMAGE = gromby/mongodb-base
VERSIONS = 3.2.4
VERSION =

all:
	@echo "Supported versions: $(VERSIONS)"
	@echo "Available targets:"
	@echo "  * build - build images"
	@echo "  * release - push to Docker Hub"
	@echo "  * cleanup - remove images"

build:
	@$(foreach var,$(VERSIONS),$(MAKE) do/build VERSION=$(var);)
	@$(MAKE) do/tag-latest VERSION=$(word $(words $(VERSIONS)),$(VERSIONS))

do/build:
	@echo "=> building $(IMAGE):$(VERSION)"
	docker build -t $(IMAGE):$(VERSION) -f versions/$(VERSION)/Dockerfile .

do/tag-latest:
	@echo "=> tagging $(IMAGE):$(VERSION)"
	docker tag -f $(IMAGE):$(VERSION) $(IMAGE):latest

release:
	@$(foreach var,$(VERSIONS),$(MAKE) do/release VERSION=$(var);)
	docker push $(IMAGE):latest

do/release:
	@echo "=> pushing $(IMAGE):$(VERSION)"
	docker push $(IMAGE):$(VERSION)

cleanup:
	@$(foreach var,$(VERSIONS),$(MAKE) do/cleanup VERSION=$(var);)
	@echo "=> removing $(IMAGE):latest"
	docker rmi $(IMAGE):latest

do/cleanup:
	@echo "=> removing $(IMAGE):$(VERSION)"
	docker rmi $(IMAGE):$(VERSION)