.PHONY: build

start:
	docker-compose up -d

server:
	docker-compose run --rm app php src/server.php

agent:
	docker-compose exec app php src/agent.php

stop:
	docker-compose down

build:
	docker-compose build
	docker-compose run --rm app composer install

update:
	docker-compose run app composer update -o --with-dependencies

logs:
	docker-compose logs --follow

test: start
	APP_ENV=test docker-compose run app vendor/bin/phpunit
