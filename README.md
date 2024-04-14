# My Podman Experiments

A simple set of podman experiments

Images are stored in: 

    https://quay.io/repository/ 

e.g:

    https://quay.io/repository/mwoodpatrick/myimage

Before commit changes to github need to login:

    gh auth login

Before pushing images need to login to repository:

    podman login quay.io

# myapp

Simple app that creates a container running Red Hat Enterprise Linux version 8.9 (Ootpa)

    cd myapp/
    podman build -t quay.io/mwoodpatrick/myimage .
    podman image ls
    podman run -u root -it quay.io/mwoodpatrick/myimage echo "hello world"
