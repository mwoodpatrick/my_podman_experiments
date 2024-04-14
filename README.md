# My Podman Experiments

A simple set of podman experiments

Images are stored in: 

    https://quay.io/repository/ 

e.g:

    https://quay.io/repository/mwoodpatrick/myimage

Before commit changes to github need to login:

    gh auth login
    git config credential.helper store
    git config --global credential.helper "cache --timeout 7200"
    git help credentials
    man git-credential-store

Before pushing images need to login to repository:

    podman login quay.io

# myapp

Simple app that creates a container running Red Hat Enterprise Linux version 8.9 (Ootpa)

    cd myapp/
    podman build -t quay.io/mwoodpatrick/myimage .
    podman image ls
    podman run -u root -it quay.io/mwoodpatrick/myimage echo "hello world"
    podman run -u root -it -v /mnt:/mnt quay.io/mwoodpatrick/myimage bash

# mynginx

Simple copy of nginx container based image docker.io/library/nginx with some extra packages (Debian 12 OS):

    podman run -d --name nginx nginx
    podman exec -it nginx bash
    apt-get install procps
    apt-get install less
    podman container commit -q --author "Mark Wood-Patrick" nginx my-nginx

Run my image:

    podman run -d -v $PWD/config:/etc/nginx -v $PWD/html:/usr/share/nginx/html -v $PWD/logs:/var/log/nginx -v /mnt:/mnt -p 8080:80 --name my-nginx my-nginx

config files in: /etc/nginx
document root: /usr/share/nginx/html
log files in: /var/log/nginx

[NGINX Product Documentation](https://docs.nginx.com/)
[Web Server](https://docs.nginx.com/nginx/admin-guide/web-server)
[Deploying NGINX and NGINX Plus with Docker](https://www.nginx.com/blog/deploying-nginx-nginx-plus-docker/)
