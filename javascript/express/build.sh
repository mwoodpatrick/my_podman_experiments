#!/bin/bash
podman build -t quay.io/mwoodpatrick/javascript-express .
podman push quay.io/mwoodpatrick/javascript-express
