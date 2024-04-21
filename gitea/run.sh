# Not woking yet see podman-create.sh
# Create basic Gitea site using Podman pods.
# https://blog.while-true-do.io/podman-setup-gitea/
# https://docs.gitea.com/installation/install-with-docker
# Set environment variables:
DB_NAME='gitea'
DB_PASS='mysupersecurepass'
DB_USER='justbeauniqueuser'
POD_NAME='gitea_with_mariadb'
CONTAINER_NAME_DB='gitea_db'
CONTAINER_NAME_GITEA='gitea'

mkdir -p html
mkdir -p database

# Remove previous attempts
podman pod rm -f $POD_NAME

# Pull before run, bc: invalid reference format error
podman pull docker.io/mariadb:latest
podman pull docker.io/gitea:latest

# Create a pod so both containers are able to reach each others.
podman pod create -n $POD_NAME -p 8090:80

podman run --detach --pod $POD_NAME \
-e MYSQL_ROOT_PASSWORD=$DB_PASS \
-e MYSQL_PASSWORD=$DB_PASS \
-e MYSQL_DATABASE=$DB_NAME \
-e MYSQL_USER=$DB_USER \
--name $CONTAINER_NAME_DB -v "$PWD/database":/var/lib/mysql \
docker.io/mariadb:latest

podman run --detach --pod $POD_NAME \
-e GITEA_DB_HOST=127.0.0.1:3306 \
-e GITEA_DB_NAME=$DB_NAME \
-e GITEA_DB_USER=$DB_USER \
-e GITEA_DB_PASSWORD=$DB_PASS \
--name $CONTAINER_NAME_GITEA -v "$PWD/html":/var/www/html \
gitea/gitea:latest-rootless # docker.io/gitea:latest

# podman run -d --name=gitea -p 3000:3000 -p 2222:22 -v gitea_data:/data gitea/gitea:latest-rootless
