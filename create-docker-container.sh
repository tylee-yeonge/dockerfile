set -e
IMAGE=$1
CONTAINER=$2
docker create -it \
  --env="DISPLAY=host.docker.internal:0" \
  --net="host" \
  --name "${CONTAINER}"\
  --platform linux/amd64 \
  --privileged \
  -v "/etc/localtime:/etc/localtime:ro" -e TZ=Asia/Seoul \
  -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  "${IMAGE}"
