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
	make all DOCKERFILE=3.0/alpine VERSION=3.0.2-alpine \
	         TAGS=3.0-alpine,3-alpine,alpine
	make all DOCKERFILE=2.5/alpine VERSION=2.5.8-alpine \
	         TAGS=2.5-alpine,2-alpine


.PHONY: container tags all everything
