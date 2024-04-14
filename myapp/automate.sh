#!/bin/bash
podman build -t quay.io/mwoodpatrick/myimage ./myapp
podman push quay.io/mwoodpatrick/myimage
