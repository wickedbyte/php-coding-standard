# By default, Makefiles are executed with /bin/sh, which may not support certain
# features like `$(shell ...)` or `$(if ...)`. To ensure compatibility, we
# explicitly set the shell to bash.
SHELL := /bin/bash

# Set bash shell flags for strict error handling
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error and exit immediately.
# -o pipefail: Make pipelines (e.g. `printenv | sort` ) fail if any command in the pipeline fails.
# -c: read the command from the following string (required).
.SHELLFLAGS := -euo pipefail -c

.DEFAULT_GOAL := all

BUILD_DIR := build
BUILD_DIR_STAMP := $(BUILD_DIR)/.install

# Detect if we are in a TTY
IS_TTY := $(shell [ -t 1 ] && echo 1 || echo 0)

DOCKER_USER ?= $(shell id -u):$(shell id -g)
DOCKER_RUN_IMAGE ?= composer:latest
DOCKER_RUN_PULL_IMAGE ?= missing
DOCKER_RUN_FLAGS = --rm $(if $(IS_TTY),--tty) --pull="$(DOCKER_RUN_PULL_IMAGE)" --volume="./:/app"
docker-run = docker run $(DOCKER_RUN_FLAGS) --user="$(DOCKER_USER)" $(DOCKER_RUN_IMAGE)

.PHONY: all
all: vendor/autoload.php $(BUILD_DIR_STAMP)

$(BUILD_DIR_STAMP):
	mkdir --parents build
	echo $(date --iso-8601=seconds --utc) > $(BUILD_DIR_STAMP)

vendor/autoload.php: $(BUILD_DIR_STAMP)
	$(MAKE) install
	touch "$@"

.PHONY: clean
clean:
	rm -rf ./build ./vendor

bash: DOCKER_RUN_FLAGS += --interactive
bash: $(BUILD_DIR_STAMP)
	$(docker-run) bash

.PHONY: install
install: $(BUILD_DIR_STAMP)
	$(docker-run) composer install

.PHONY: update
update: vendor/autoload.php
	$(docker-run) composer update --with-all-dependencies

.PHONY: upgrade
upgrade: vendor/autoload.php
	$(docker-run) composer require --update-with-all-dependencies \
		dealerdirect/phpcodesniffer-composer-installer \
		slevomat/coding-standard \
		squizlabs/php_codesniffer

.PHONY: test
test: vendor/autoload.php
	$(docker-run) find ./tests -type f -name *.php -exec php -l {} +
	$(docker-run) vendor/bin/phpcs

