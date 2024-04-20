#!/bin/bash
podman build -t quay.io/mwoodpatrick/unit-flask .
podman push quay.io/mwoodpatrick/unit-flask
