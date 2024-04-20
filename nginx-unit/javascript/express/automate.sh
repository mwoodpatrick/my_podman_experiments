#!/bin/bash
sudo podman build -t quay.io/mwoodpatrick/unit-express .
sudo podman push quay.io/mwoodpatrick/unit-express
