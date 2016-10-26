# Build Kahlan Docker image(s)
#
#
# Usage
#
# Build single container of concrete version:
# 	make container [VERSION=] [DOCKERFILE=] [no-cache=(yes|no)]
#
# Tag single container with given tags:
# 	make tags [VERSION=] [TAGS=t1,t2,...]
#
# Perform all operations for concrete version:
# 	make all [VERSION=] [TAGS=t1,t2,...] [DOCKERFILE=] [no-cache=(yes|no)]
#
# Build and tag containers of all possible versions:
# 	make everything [no-cache=(yes|no)]
#


NAME := kahlan/kahlan
VERSION ?= 3.0.2-alpine
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


container:
	docker build $(no-cache-arg) -t $(NAME):$(VERSION) $(DOCKERFILE)

tags:
	$(foreach tag, $(parsed-tags), \
		docker tag $(NAME):$(VERSION) $(NAME):$(tag); \
	)


all: | container tags


everything:
	make all DOCKERFILE=3.0/debian VERSION=3.0.2 \
	         TAGS=3.0,3,latest
	make all DOCKERFILE=3.0/php5-debian VERSION=3.0.2 \
	         TAGS=3.0-php5,3-php5,php5
	make all DOCKERFILE=3.0/alpine VERSION=3.0.2-alpine \
	         TAGS=3.0-alpine,3-alpine,alpine
	make all DOCKERFILE=3.0/php5-alpine VERSION=3.0.2-php5-alpine \
	         TAGS=3.0-php5-alpine,3-php5-alpine,php5-alpine
	make all DOCKERFILE=2.5/debian VERSION=2.5.8 \
	         TAGS=2.5,2
	make all DOCKERFILE=2.5/php5-debian VERSION=2.5.8-php5 \
	         TAGS=2.5-php5,2-php5
	make all DOCKERFILE=2.5/alpine VERSION=2.5.8-alpine \
	         TAGS=2.5-alpine,2-alpine
	make all DOCKERFILE=2.5/php5-alpine VERSION=2.5.8-php5-alpine \
	         TAGS=2.5-php5-alpine,2-php5-alpine


.PHONY: container tags all everything




# Build Dockerfiles for Kahlan Docker image
#
#
# Usage
#
# Build single concrete Dockerfile:
# 	make dockerfile [DOCKERFILE=] [[var_(<template_var>)=]]
#
# Build all Dockerfiles for currently supported Docker image versions:
#	make all-dockerfiles
#

var_kahlan_ver ?= 3.0.2
var_composer_tag ?= latest

dockerfile:
	docker run --rm -i \
		-v $(PWD)/Dockerfile-template.j2:/data/Dockerfile.j2:ro \
		-e TEMPLATE=Dockerfile.j2 \
		pinterb/jinja2 \
			kahlan_ver='$(var_kahlan_ver)' \
			composer_tag='$(var_composer_tag)' \
		> $(DOCKERFILE)/Dockerfile

all-dockerfiles:
	make dockerfile DOCKERFILE=3.0/debian \
		var_kahlan_ver=3.0.2 \
		var_composer_tag=latest
	make dockerfile DOCKERFILE=3.0/php5-debian \
		var_kahlan_ver=3.0.2 \
		var_composer_tag=php5
	make dockerfile DOCKERFILE=3.0/alpine \
		var_kahlan_ver=3.0.2 \
		var_composer_tag=alpine
	make dockerfile DOCKERFILE=3.0/php5-alpine \
		var_kahlan_ver=3.0.2 \
		var_composer_tag=php5-alpine
	make dockerfile DOCKERFILE=2.5/debian \
		var_kahlan_ver=2.5.8 \
		var_composer_tag=latest
	make dockerfile DOCKERFILE=2.5/php5-debian \
		var_kahlan_ver=2.5.8 \
		var_composer_tag=php5
	make dockerfile DOCKERFILE=2.5/alpine \
		var_kahlan_ver=2.5.8 \
		var_composer_tag=alpine
	make dockerfile DOCKERFILE=2.5/php5-alpine \
		var_kahlan_ver=2.5.8 \
		var_composer_tag=php5-alpine

.PHONY: dockerfile all-dockerfiles
