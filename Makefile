name = inception


all:
	@bash srcs/requirements/wordpress/tools/create_dir.sh
	@bash srcs/requirements/nginx/tools/create_crt.sh
	@docker compose -f ./srcs/docker-compose.yml up -d

portainer:
	@docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.19.5

build:
	@bash srcs/requirements/wordpress/tools/create_dir.sh
	@bash srcs/requirements/nginx/tools/create_crt.sh
	@docker compose -f ./srcs/docker-compose.yml build

down:
	@docker compose -f ./srcs/docker-compose.yml down
	@docker stop portainer

clean: down
	@docker system prune -a

fclean:
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

.PHONY: all build down re clean fclean
