export UNIT=$(                                                         \
      podman run -d                                                      \
      --mount type=bind,src="$(pwd)/config/",dst=/docker-entrypoint.d/   \
      --mount type=bind,src="$(pwd)/log/unit.log",dst=/var/log/unit.log  \
      --mount type=bind,src="$(pwd)/state",dst=/var/lib/unit             \
      --mount type=bind,src="$(pwd)/.",dst=/www                     \
      --name nginx-unit-flask -p 8081:8000 unit-flask                                           \
  )
