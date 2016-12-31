all:
	docker-compose build
	docker push yurifl/eclipse:latest
