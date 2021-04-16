# theos-docker

Docker image for Theos, based on Ubuntu 20.04.

## Building

Clone this repo recursively and cd into it. Then,

```
docker-compose up --build --no-start
```

## Usage

Start the container whenever and in any directory, with

```
docker start -i theos
```

Data stored in `~/work` will be persisted in a Docker volume even if the container is deleted and re-created.
