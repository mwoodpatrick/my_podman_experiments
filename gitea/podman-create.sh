# https://about.gitea.com/
# https://github.com/go-gitea/gitea
# https://github.com/pswilde/gitea-podman/blob/main/podman-run.sh
#!/bin/bash

podman rm -f gitea
podman run -d \
	--name gitea \
	-v ./data:/var/lib/gitea \
	-v ./config:/etc/gitea \
	-v /etc/timezone:/etc/timezone:ro \
	-v /etc/localtime:/etc/localtime:ro \
	-p 2222:2222 \
	-p 3000:3000 \
	gitea/gitea:1.21.10-rootless # gitea/gitea:latest"

