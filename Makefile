# Build Kahlan Docker image(s)
#
#
# Usage
#
# Build single Docker image of concrete version:
# 	make image [VERSION=] [DOCKERFILE=] [no-cache=(yes|no)]
#
# Tag single Docker image with given tags:
# 	make tags [VERSION=] [TAGS=t1,t2,...]
#
# Build and tag Docker image of concrete version:
# 	make all [VERSION=] [TAGS=t1,t2,...] [DOCKERFILE=] [no-cache=(yes|no)]
#
# Build and tag Docker images of all possible versions:
# 	make everything [no-cache=(yes|no)]
#


IMAGE_NAME := kahlan/kahlan
VERSION ?= 3.0.3-alpine
TAGS ?= 3.0-alpine,3-alpine,alpine
DOCKERFILE ?= 3.0/alpine
no-cache ?= no

comma:= ,
empty:=
space:= $(empty) $(empty)
eq = $(if $(or $(1),$(2)),$(and $(findstring $(1),$(2)),\
                                $(findstring $(2),$(1))),1)

no-cache-arg = $(if $(call eq, $(no-cache), yes), --no-cache, $(empty))
parsed-tags = $(subst $(comma), $(space), $(TAGS))


image:
	docker build $(no-cache-arg) -t $(IMAGE_NAME):$(VERSION) $(DOCKERFILE)

tags:
	(set -e ; $(foreach tag, $(parsed-tags), \
		docker tag $(IMAGE_NAME):$(VERSION) $(IMAGE_NAME):$(tag) ; \
	))

all: | image tags

everything:
	make all DOCKERFILE=3.0/debian VERSION=3.0.3 \
	         TAGS=3.0,3,latest
	make all DOCKERFILE=3.0/php5-debian VERSION=3.0.3 \
	         TAGS=3.0-php5,3-php5,php5
	make all DOCKERFILE=3.0/alpine VERSION=3.0.3-alpine \
	         TAGS=3.0-alpine,3-alpine,alpine
	make all DOCKERFILE=3.0/php5-alpine VERSION=3.0.3-php5-alpine \
	         TAGS=3.0-php5-alpine,3-php5-alpine,php5-alpine
	make all DOCKERFILE=2.5/debian VERSION=2.5.8 \
	         TAGS=2.5,2
	make all DOCKERFILE=2.5/php5-debian VERSION=2.5.8-php5 \
	         TAGS=2.5-php5,2-php5
	make all DOCKERFILE=2.5/alpine VERSION=2.5.8-alpine \
	         TAGS=2.5-alpine,2-alpine
	make all DOCKERFILE=2.5/php5-alpine VERSION=2.5.8-php5-alpine \
	         TAGS=2.5-php5-alpine,2-php5-alpine

.PHONY: image tags all everything




# Build Dockerfiles for Kahlan Docker image
#
# When Dockerhub triggers automated build all the tags defined in post_push hook
# will be assigned to built image. It allows to link the same image with
# different tags, and not to build identical image for each tag separately.
# See details:
# http://windsock.io/automated-docker-image-builds-with-multiple-tags/
#
#
# Usage
#
# Build single concrete Dockerfile:
#	make dockerfile [DOCKERFILE=] [[var_(<template_var>)=]]
#
# Create post_push Dockerhub hook for concrete Dockerfile:
#	make dockerhub-post-push-hook [DOCKERFILE=] [TAGS=t1,t2,...]
#
# Build Dockerfile and its context for all currently supported Docker image
# versions:
#	make all-docker-sources
#

var_kahlan_ver ?= 3.0.3
var_composer_tag ?= latest

dockerfile:
	mkdir -p $(DOCKERFILE)
	docker run --rm -i \
		-v $(PWD)/Dockerfile-template.j2:/data/Dockerfile.j2:ro \
		-e TEMPLATE=Dockerfile.j2 \
		pinterb/jinja2 \
			kahlan_ver='$(var_kahlan_ver)' \
			php_tag='$(var_php_tag)' \
		> $(DOCKERFILE)/Dockerfile

dockerhub-post-push-hook:
	mkdir -p $(DOCKERFILE)/hooks
	docker run --rm -i \
		-v $(PWD)/post_push.j2:/data/post_push.j2:ro \
		-e TEMPLATE=post_push.j2 \
		pinterb/jinja2 \
			image_tags='$(TAGS)' \
		> $(DOCKERFILE)/hooks/post_push

all-docker-sources:
	make dockerfile DOCKERFILE=3.0/debian \
		var_kahlan_ver=3.0.3 \
		var_php_tag=cli
	make dockerhub-post-push-hook DOCKERFILE=3.0/debian \
		TAGS=3.0.3,3.0,3,latest

	make dockerfile DOCKERFILE=3.0/php5-debian \
		var_kahlan_ver=3.0.3 \
		var_php_tag=5-cli
	make dockerhub-post-push-hook DOCKERFILE=3.0/php5-debian \
		TAGS=3.0.3-php5,3.0-php5,3-php5,php5

	make dockerfile DOCKERFILE=3.0/alpine \
		var_kahlan_ver=3.0.3 \
		var_php_tag=alpine
	make dockerhub-post-push-hook DOCKERFILE=3.0/alpine \
		TAGS=3.0.3-alpine,3.0-alpine,3-alpine,alpine

	make dockerfile DOCKERFILE=3.0/php5-alpine \
		var_kahlan_ver=3.0.3 \
		var_php_tag=5-alpine
	make dockerhub-post-push-hook DOCKERFILE=3.0/php5-alpine \
		TAGS=3.0.3-php5-alpine,3.0-php5-alpine,3-php5-alpine,php5-alpine

	make dockerfile DOCKERFILE=2.5/debian \
		var_kahlan_ver=2.5.8 \
		var_php_tag=cli
	make dockerhub-post-push-hook DOCKERFILE=2.5/debian \
		TAGS=2.5.8,2.5,2

	make dockerfile DOCKERFILE=2.5/php5-debian \
		var_kahlan_ver=2.5.8 \
		var_php_tag=5-cli
	make dockerhub-post-push-hook DOCKERFILE=2.5/php5-debian \
		TAGS=2.5.8-php5,2.5-php5,2-php5

	make dockerfile DOCKERFILE=2.5/alpine \
		var_kahlan_ver=2.5.8 \
		var_php_tag=alpine
	make dockerhub-post-push-hook DOCKERFILE=2.5/alpine \
		TAGS=2.5.8-alpine,2.5-alpine,2-alpine

	make dockerfile DOCKERFILE=2.5/php5-alpine \
		var_kahlan_ver=2.5.8 \
		var_php_tag=5-alpine
	make dockerhub-post-push-hook DOCKERFILE=2.5/php5-alpine \
		TAGS=2.5.8-php5-alpine,2.5-php5-alpine,2-php5-alpine

.PHONY: dockerfile dockerhub-post-push-hook all-docker-sources




# Test Kahlan Docker image(s)
#
#
# Usage
#
# Run tests of concrete Docker image version:
#	make test [VERSION=]
#
# Run tests for all possible Docker image versions:
#	make all-tests [no-cache=(yes|no)]
#

dockerfiles := 3.0/debian 3.0/alpine 3.0/php5-debian 3.0/php5-alpine \
               2.5/debian 2.5/alpine 2.5/php5-debian 2.5/php5-alpine

test:
	IMAGE=$(IMAGE_NAME):$(VERSION) \
	./test/bats/bats test/suite.bats

all-tests:
	(set -e ; $(foreach dockerfile, $(dockerfiles), \
		make image DOCKERFILE=$(dockerfile) \
		           VERSION=$(subst /,-,$(dockerfile))-testing ; \
	))
	(set -e ; $(foreach dockerfile, $(dockerfiles), \
		make test VERSION=$(subst /,-,$(dockerfile))-testing ; \
	))

.PHONY: test all-tests
