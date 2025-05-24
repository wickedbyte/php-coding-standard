SHELL := bash
.DEFAULT_GOAL := vendor

build:
	docker pull composer:latest
	mkdir --parents build

vendor: build
	docker run --rm --interactive --tty \
		--user $(shell id -u):$(shell id -g) \
		--volume $(shell pwd):/app \
		composer:latest install

bash: build
	docker run --rm --interactive --tty \
		--user $(shell id -u):$(shell id -g) \
		--volume $(shell pwd):/app \
		composer:latest bash

.PHONY: upgrade
upgrade: build
	docker run --rm --interactive --tty \
		--user $(shell id -u):$(shell id -g) \
		--volume $(shell pwd):/app \
		composer:latest require -W dealerdirect/phpcodesniffer-composer-installer slevomat/coding-standard squizlabs/php_codesniffer

.PHONY: clean
clean:
	rm -rf ./build ./vendor



