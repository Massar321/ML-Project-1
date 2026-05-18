FROM  debian:bookworm-slim

WORKDIR /APP

#COPY . . 

#CMD [ "echo", "Hello World !" ]

############################################################################################
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates
ENV UV_NO_DEV=1
ENV UV_COMPILE_BYTECODE=1
ENV UV_PYTHON_DOWNLOADS=auto

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

#optimization 
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-install-project

COPY . . 

RUN uv sync --frozen
#RUN uv sync --locked
CMD [ "uv", "run", "python", "--version" ]
#CMD [ "uv","--version" ]

#docker build -t docker-projet .
#docker run docker-projet
#docker run -it docker-projet bash
#ls 
#exit
#docker run --name mon-container docker-projet -- nommer le container
#docker start mon-container -- attach
#docker rm mon-container --- supprimer le container
#docker rmi docker-projet --- supprimer l'image

#pip install uv
#py -m pip install uv
#py -m uv init
#py -m uv sync 
#docker build -t docker-projet .
# docker build -t docker-image-uv .
#docker run --name mon-container-uv docker-image-uv
#docker run --name mon-container-uv docker-image-u
#docker rm mon-container
# docker build -t docker-image-uv2:v1 . 
#docker run --name mon-container-uv docker-image-uv2:v1