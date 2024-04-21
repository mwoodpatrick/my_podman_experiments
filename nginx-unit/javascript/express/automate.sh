#!/bin/bash
podman build -t quay.io/mwoodpatrick/unit-node-express .
podman push quay.io/mwoodpatrick/unit-node-express
