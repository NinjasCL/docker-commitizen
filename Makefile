COMMITIZEN = $(shell pwd)/.commitizen
IMAGE_COMMITIZEN = ninjas-commitizen-env
RUN_COMMITIZEN = docker run --rm -it --mount src="$(shell pwd)",target=/src,type=bind $(IMAGE_COMMITIZEN)

gc git-config:
	# Enables git cz as alias for make commit
	mv .gitconfig.example .gitconfig
	# This enables the .commitizen dir access the .gitconfig in root
	git config --local include.path ../.gitconfig

c cz commit:
	$(RUN_COMMITIZEN) /bin/sh -c "npm run commit --prefix=./.commitizen"

nbc node-build-commitizen:
	docker build -f $(COMMITIZEN)/Dockerfile -t $(IMAGE_COMMITIZEN) $(COMMITIZEN)

nsc node-shell-commitizen:
	$(RUN_COMMITIZEN) /bin/bash

nic node-install-commitizen:
	make node-build-commitizen
	make git-config
