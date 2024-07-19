name = inception


all:
	@bash srcs/requirements/wordpress/tools/create_dir.sh
	@bash srcs/requirements/nginx/tools/create_crt.sh
	@docker compose -f ./srcs/docker-compose.yml up -d

build:
	@bash srcs/requirements/wordpress/tools/create_dir.sh
	@bash srcs/requirements/nginx/tools/create_crt.sh
	@docker compose -f ./srcs/docker-compose.yml build

down:
	@docker compose -f ./srcs/docker-compose.yml down

clean: down
	@docker system prune -a
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

fclean:
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

.PHONY: all build down re clean fclean
