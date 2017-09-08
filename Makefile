-include env_make

NAMESPACE = augustash
NAME = alpine-$(shell basename $(PWD))
IMAGE = $(NAMESPACE)/$(NAME)
TAG ?= latest
INSTANCE = default

.PHONY: build clean logs push quick-run release run shell ssh start stop

default: build

build:
	docker build -t $(IMAGE):$(TAG) ./

clean:
	docker rm -f $(NAME)-$(INSTANCE)

logs:
	docker logs $(NAME)-$(INSTANCE)

push:
	docker push $(IMAGE):$(TAG)

quick-run:
	docker run --rm --name $(NAME)-$(INSTANCE) --entrypoint /usr/bin/php $(PORTS) $(VOLUMES) $(ENV) $(IMAGE):$(TAG) $(CMD)

release: build
	make push -e TAG=$(TAG)

run:
	docker run --rm --name $(NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(IMAGE):$(TAG) $(CMD)

shell:
	docker run --rm --name $(NAME)-$(INSTANCE) -it $(PORTS) $(VOLUMES) $(ENV) $(IMAGE):$(TAG) /bin/bash

ssh:
	docker exec -it $(NAME)-$(INSTANCE) /bin/bash

start:
	docker run -d --name $(NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(IMAGE):$(TAG) $(CMD)

stop:
	docker stop $(NAME)-$(INSTANCE)
