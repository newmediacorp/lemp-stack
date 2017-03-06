.PHONY: start
 
start:
	docker-compose up -d

stop:
	docker-compose stop

list:
	docker-compose ps

shell:
	docker-compose exec phpfpm bash

destroy:
	docker-compose down

logs:
	docker-compose logs -f phpfpm

default: start