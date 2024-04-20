# Simple Python Flask Application

[Unit in Docker — NGINX Unit](https://unit.nginx.org/howto/docker/)

[Flask Tutorial - GeeksforGeeks](https://www.geeksforgeeks.org/flask-tutorial/)

mkdir flask
 cd flask
 cat << EOF > wsgi.py

from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'
EOF

 cat << EOF > requirements.txt

flask
EOF

 mkdir config
 cat << EOF > config/config.json

{
    "listeners":{
        "*:8000":{
            "pass":"applications/webapp"
        }
    },

    "applications":{
        "webapp":{
            "type":"python 3",
            "path":"/www/",
            "module": "wsgi",
             "callable": "app"
        }
    }
}
EOF

 mkdir log
 touch log/unit.log
 mkdir state
 cat << EOF >  automate.sh
#!/bin/bash
podman build -t quay.io/mwoodpatrick/unit-flask .
podman push quay.io/mwoodpatrick/unit-flask
EOF
cat << EOF > Containerfile
FROM unit:python3.12
COPY requirements.txt /config/requirements.txt
RUN python3 -m pip install -r /config/requirements.txt
EOF

 podman login quay.io
 ./automate.sh # build image and push to  quay.io

[Repositories · Quay](https://quay.io/repository/)

cat << EOF > run.sh
export UNIT=$(                                                         \
      podman run -d                                                      \
      --mount type=bind,src="$(pwd)/config/",dst=/docker-entrypoint.d/   \
      --mount type=bind,src="$(pwd)/log/unit.log",dst=/var/log/unit.log  \
      --mount type=bind,src="$(pwd)/state",dst=/var/lib/unit             \
      --mount type=bind,src="$(pwd)/.",dst=/www                     \
      --name nginx-unit-flask -p 8081:8000 unit-flask                                           \
  )
EOF

chmod +x run.sh

./run.sh
