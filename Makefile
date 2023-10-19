LOGIN			:= zpalfi
YML_PATH		:= srcs/docker-compose.yml
VOLUMES_PATH		:= /home/$(LOGIN)/data

export VOLUMES_PATH

all: setup up

up:
	docker compose --file=$(YML_PATH) up --build --detach

down:
	docker compose --file=$(YML_PATH) down

srcs/.env:
	@echo "Missing .env file in srcs folder" && exit 1

clean:
	@echo "Cleaning volumes folders..."
	@sudo rm -rf $(VOLUMES_PATH)
	@echo "Stoping and deleting containers..."
	@docker stop $$(docker ps -qa)
	@docker rm $$(docker ps -qa)
	@echo "Deleting images, volumes and network..."
	@docker rmi $$(docker images -qa)
	@docker volume rm $$(docker volume ls -q)
	@docker network rm inception

setup: srcs/.env
	@echo "Creating volumes folders..."
	@mkdir -p $(VOLUMES_PATH)/wordpress
	@mkdir -p $(VOLUMES_PATH)/mariadb
	@echo "Adding '12.0.0.1 $(LOGIN).42.fr' into /etc/hosts..."
	@grep $(LOGIN).42.fr /etc/hosts || echo "127.0.0.1 $(LOGIN).42.fr" >> /etc/hosts
	@echo "Adding VOLUMES_PATH into .env file..."
	@grep VOLUMES_PATH srcs/.env || echo "VOLUMES_PATH=$(VOLUMES_PATH)" >> srcs/.env
