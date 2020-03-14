SHELL := /bin/bash
.ONESHELL:
phpactor-install-extensions:
	cd pack/bundle/start/phpactor
	mapfile -t exts < config/travis/extensions-to-test
	./bin/phpactor extension:install "$${exts[@]}"
