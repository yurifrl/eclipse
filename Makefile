all:
	docker-compose build --force-rm
	docker push yurifl/eclipse:latest
