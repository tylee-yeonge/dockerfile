set -e
IMAGE=$1
CONTAINER=$2
docker create -it \
  --env="DISPLAY" \
  --net="host" \
  --name "${CONTAINER}"\
  --platform linux/amd64 \
  --privileged \
  -v "/etc/localtime:/etc/localtime:ro" -e TZ=Asia/Seoul \
  "${IMAGE}"
