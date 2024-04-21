# Create basic WordPress site using Podman pods.
# https://stackoverflow.com/questions/74054932/how-to-install-and-setup-wordpress-using-podman
# https://docs.docker.com/samples/wordpress/
# Set environment variables:
DB_NAME='wordpress_db'
DB_PASS='mysupersecurepass'
DB_USER='justbeauniqueuser'
POD_NAME='wordpress_with_mariadb'
CONTAINER_NAME_DB='wordpress_db'
CONTAINER_NAME_WP='wordpress'

mkdir -p html
mkdir -p database

# Remove previous attempts
podman pod rm -f $POD_NAME

# Pull before run, bc: invalid reference format error
podman pull docker.io/mariadb:latest
podman pull docker.io/wordpress

# Create a pod instead of --link. 
# So both containers are able to reach each others.
podman pod create -n $POD_NAME -p 8090:80

podman run --detach --pod $POD_NAME \
-e MYSQL_ROOT_PASSWORD=$DB_PASS \
-e MYSQL_PASSWORD=$DB_PASS \
-e MYSQL_DATABASE=$DB_NAME \
-e MYSQL_USER=$DB_USER \
--name $CONTAINER_NAME_DB -v "$PWD/database":/var/lib/mysql \
docker.io/mariadb:latest

podman run --detach --pod $POD_NAME \
-e WORDPRESS_DB_HOST=127.0.0.1:3306 \
-e WORDPRESS_DB_NAME=$DB_NAME \
-e WORDPRESS_DB_USER=$DB_USER \
-e WORDPRESS_DB_PASSWORD=$DB_PASS \
--name $CONTAINER_NAME_WP -v "$PWD/html":/var/www/html \
docker.io/wordpress
